//
//  MyTerminalUITests.swift
//  MyTerminalUITests
//
//  Created by Mitchell Tol on 19/02/2025.
//

import XCTest

final class MyTerminalStartupTests: XCTestCase {
    
    let options = XCTMeasureOptions()
    
    // Configuration
    let n = 1
    var metrics = [XCTApplicationLaunchMetric()]
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        options.iterationCount = n
    }

    func test_Startup() throws {
        measure(metrics: metrics, options: options) {
            let app = XCUIApplication()
            app.launch()
        }
    }
}
