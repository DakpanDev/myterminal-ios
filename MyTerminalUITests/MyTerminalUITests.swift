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
    let n = 1
    var metrics: [XCTMetric] {
        [
            XCTApplicationLaunchMetric(),
            XCTCPUMetric(application: app),
            XCTMemoryMetric(application: app),
            XCTClockMetric()
        ]
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        options.iterationCount = n
    }
    
    override func tearDownWithError() throws {
        app.terminate()
    }

    func testA_LoadFlights() throws {
        measure(metrics: metrics, options: options) {
            app.launch()
            
            let scrollView = app.scrollViews["scrollList"]
            for _ in 1...6 {
                scrollView.swipeUp()
            }
            
            app.datePickers["datePicker"].tap()
            app.buttons["Saturday, 3 May"].tap()
            app.buttons["dismiss popup"].tap()

            for _ in 1...6 {
                scrollView.swipeUp()
            }
        }
    }
    
    func testB_OpenDetails() throws {
        measure(metrics: metrics, options: options) {
            app.launch()
            
            let flights = app.otherElements["flightList"].descendants(matching: .any)
            for i in 0...3 {
                flights.element(boundBy: i).tap()
                app.buttons["Back"].tap()
            }
        }
    }
    
    func testC_BookmarkFlight() throws {
        measure(metrics: metrics, options: options) {
            app.launch()
            
            app.otherElements["flightList"]
                .descendants(matching: .any)
                .element(boundBy: 0)
                .tap()
            
            sleep(1)
            
            for _ in 1...10 {
                app.otherElements["bookmarkFlight"].tap()
            }
        }
    }
    
    func testD_LoadBookmarks() throws {
        measure(metrics: metrics, options: options) {
            app.launch()
            
            app.buttons["bookmarks"].tap()
        }
    }
}
