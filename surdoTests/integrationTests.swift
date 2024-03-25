//
//  integrationTests.swift
//  surdoTests
//
//  Created by Rustem Orazbayev on 3/25/24.
//

import XCTest
import Combine
@testable import surdo

final class LeaderboardIntegrationTests: XCTestCase {
    var sut: LeaderboardViewController!
    var db = DatabaseManager()
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        sut = LeaderboardViewController()
        sut.loadViewIfNeeded()
        sut.fetchUsers()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testFetchUsers() {
        // Given
        sut.users = []

        // When
        sut.fetchUsers()

        // Then
        XCTAssertEqual(sut.users.count, 0)
    }

    func testDescendingOrder() {
        // Given
        sut.users = [("User1", "100"), ("User2", "200"), ("User3", "300")]

        // When
        sut.fetchUsers()

        // swiftlint: disable all
        // Then
        var isSortedAscending = true
        for i in 0..<sut.users.count - 1 {
            let currentScore = Int(sut.users[i].learningScore)!
            let nextScore = Int(sut.users[i + 1].learningScore)!
            if currentScore < nextScore {
                isSortedAscending = false
                break
            }
        }

        XCTAssertFalse(isSortedAscending)
    }
    
    func testConfetti() {
        // Given
        sut = LeaderboardViewController()
        
        // When
        sut.createParticles()
        
        // Then
        XCTAssertFalse(sut.pedestalImageView.layer.contents.debugDescription.isEmpty)

    }
    
    func testNumberOfSections() {
        // Given
        let tableView = sut.leaderboardTableView

        // When
        let numberOfSections = sut.numberOfSections(in: tableView)

        // Then
        XCTAssertEqual(numberOfSections, 1)
    }
    
    func testTableViewCellForRowAt() {
        // Given
        let tableView = sut.leaderboardTableView
        sut.users = [("User1", "100"), ("User2", "200"), ("User3", "300")]

        // When
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0)) as! LeaderboardViewCell

        // Then
        XCTAssertEqual(cell.usernameLabel.text, "2. User2")
        XCTAssertEqual(cell.scoreLabel.text, "Очки: 200")
    }

    // swiftlint: enable all
}
