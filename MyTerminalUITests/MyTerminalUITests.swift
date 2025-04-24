//
//  MyTerminalUITests.swift
//  MyTerminalUITests
//
//  Created by Mitchell Tol on 19/02/2025.
//

import XCTest

final class MyTerminalUITests: XCTestCase {
    var app = XCUIApplication()
    let options = XCTMeasureOptions()
    
    // Configuration
    let n = 2
    let metrics: [XCTMetric] = [
        XCTApplicationLaunchMetric(),
        XCTCPUMetric(),
        XCTMemoryMetric(),
    ]

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        options.iterationCount = n
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }

    func testLoadFlights() throws {
        measure(metrics: metrics, options: options) {
            app.launch()
            
            let scrollView = app.scrollViews["scrollList"]
            for _ in 1...6 {
                scrollView.swipeUp()
            }
            
            app.datePickers["datePicker"].tap()
            app.buttons["Monday, 14 April"].tap()
            app.buttons["dismiss popup"].tap()

            for _ in 1...6 {
                scrollView.swipeUp()
            }
        }
    }
    
    func testOpenDetails() throws {
        measure(metrics: metrics, options: options) {
            app.launch()
            
            let flights = app.otherElements["flightList"].descendants(matching: .any)
            for i in 0...3 {
                flights.element(boundBy: i).tap()
                app.buttons["Back"].tap()
            }
        }
    }
    
    func testBookmarkFlight() throws {
        measure(metrics: metrics, options: options) {
            app.launch()
            
            app.otherElements["flightList"]
                .descendants(matching: .any)
                .element(boundBy: 0)
                .tap()
            
            for _ in 1...10 {
                app.images["Bookmark"].tap()
            }
        }
    }
    
    func testLoadBookmarks() throws {
        measure(metrics: metrics, options: options) {
            app.launch()
            
            app.buttons["bookmarks"].tap()
        }
    }
}
