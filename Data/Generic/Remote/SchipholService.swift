//
//  SchipholService.swift
//  MyTerminal
//
//  Created by Mitchell Tol on 26/02/2025.
//

import Foundation

class SchipholService {
    
    func retrieveFlights(page: Int, date: Date) async throws -> FlightListResponse {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: date)
        if let response = try await makeRequest(
            url: SchipholService.FlightsUrl,
            responseType: FlightListResponse.self,
            queryParams: Dictionary(
                uniqueKeysWithValues: [
                    (SchipholService.ParamScheduleDate, formattedDate),
                    (SchipholService.ParamPage, "\(page)"),
                    (SchipholService.ParamIncludeDelays, "false"),
                    (SchipholService.ParamFlightDirection, "D"),
                    (SchipholService.ParamSort, "+scheduleTime"),
                ]
            )
        ) {
            return response
        } else {
            throw IllegalStateError(message: "An error occurred while fetching page \(page) of date \(formattedDate)")
        }
    }
    
    func retrieveDestination(iata: String) async throws -> DestinationResponse {
        if let response = try await makeRequest(
            url: SchipholService.DestinationsUrl,
            responseType: DestinationResponse.self,
            pathSegments: [iata]
        ) {
            return response
        } else {
            throw IllegalStateError(message: "An error occurred while fetching destination with IATA \(iata)")
        }
    }
    
    private func makeRequest<T: Decodable>(
        url: String,
        responseType: T.Type,
        pathSegments: [String] = [],
        queryParams: Dictionary<String, String> = Dictionary()
    ) async throws -> T? {
        let builtUrl: String = url + pathSegments.flatMap { "/\($0)" }
        guard var components = URLComponents(string: builtUrl) else {
            return nil
        }
        
        components.queryItems = queryParams.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let validUrl = components.url else {
            print("Url is invalid")
            return nil
        }
        
        var request = URLRequest(url: validUrl)
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("v4", forHTTPHeaderField: SchipholService.HeaderResourceVersion)
        request.setValue(Const.AppId, forHTTPHeaderField: SchipholService.HeaderAppId)
        request.setValue(Const.AppKey, forHTTPHeaderField: SchipholService.HeaderAppKey)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    private static let BaseUrl = "https://api.schiphol.nl"
    private static let FlightsEndpoint = "/public-flights/flights"
    private static let DestinationsEndpoint = "/public-flights/destinations"
    private static let FlightsUrl = "\(BaseUrl)\(FlightsEndpoint)"
    private static let DestinationsUrl = "\(BaseUrl)\(DestinationsEndpoint)"

    private static let HeaderResourceVersion = "ResourceVersion"
    private static let HeaderAppId = "app_id"
    private static let HeaderAppKey = "app_key"

    private static let ParamScheduleDate = "scheduleDate"
    private static let ParamPage = "page"
    private static let ParamIncludeDelays = "includedelays"
    private static let ParamFlightDirection = "flightDirection"
    private static let ParamSort = "sort"
}
