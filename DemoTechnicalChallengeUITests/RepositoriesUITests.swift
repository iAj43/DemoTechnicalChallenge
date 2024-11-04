//
//  RepositoriesUITests.swift
//  DemoTechnicalChallengeUITests
//
//  Created by NeoSOFT on 05/11/24.
//

import XCTest

class RepositoriesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }

    // Test UI elements after fetching repositories
    func testFetchAndDisplayRepositories() {
        // Assuming there's a button to fetch repositories
        let fetchButton = app.buttons["FetchRepositories"]
        XCTAssertTrue(fetchButton.exists)
        fetchButton.tap()
        
        // Wait for data to load (you may need to adjust the wait time)
        let tablesQuery = app.tables
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: tablesQuery, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        // Check if the table view contains cells
        XCTAssertTrue(tablesQuery.cells.count > 0)
    }

    // Test search functionality
    func testSearchRepositories() {
        // First, fetch the repositories
        let fetchButton = app.buttons["FetchRepositories"]
        fetchButton.tap()

        // Wait for data to load
        let tablesQuery = app.tables
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: tablesQuery, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        // Perform a search
        let searchField = app.searchFields["SearchField"] // Update with the actual accessibility identifier
        searchField.tap()
        searchField.typeText("TestRepo")
        
        // Verify the filtered results
        XCTAssertTrue(tablesQuery.cells.count == 1)
    }
}
