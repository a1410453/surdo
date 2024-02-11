//
//  surdoTests.swift
//  surdoTests
//
//  Created by Rustem Orazbayev on 2/11/24.
//
import XCTest
import Combine
@testable import surdo
import FirebaseAuth

struct MockStorageMetadata {
    var contentType: String?
    var path: String?
}

class MockStorageManager {
    var uploadProfilePhotoResult: AnyPublisher<MockStorageMetadata, Error>?
    var getDownloadURLResult: AnyPublisher<URL, Error>?
    
    func uploadProfilePhoto(with id: String,
                            image: Data,
                            metaData:  MockStorageMetadata) -> AnyPublisher<MockStorageMetadata, Error> {
        if let result = uploadProfilePhotoResult {
            return result
        } else {
            return Fail(error: NSError(domain: "MockStorageManager",
                                       code: 0,
                                       userInfo: nil)).eraseToAnyPublisher()
        }
    }
    
    func getDownloadURL(for path: String) -> AnyPublisher<URL, Error> {
        if let result = getDownloadURLResult {
            return result
        } else {
            return Fail(error: NSError(domain: "MockStorageManager",
                                       code: 0,
                                       userInfo: nil)).eraseToAnyPublisher()
        }
    }
}

class MockDatabaseManager {
    
    var collectionUsersUpdateFieldsResult: AnyPublisher<Bool, Error>?
    
    func collectionUsers(updateFields fields: [String: Any], for id: String) -> AnyPublisher<Bool, Error> {
        if let result = collectionUsersUpdateFieldsResult {
            return result
        } else {
            return Fail(error: NSError(domain: "MockDatabaseManager",
                                       code: 0,
                                       userInfo: nil)).eraseToAnyPublisher()
        }
    }
}

class AuthenticationViewViewModelTests: XCTestCase {
    
    var viewModel: AuthenticationViewViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        viewModel = AuthenticationViewViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        cancellables = []
        super.tearDown()
    }
    
    func testValidationWithValidEmailAndPassword() {
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        viewModel.validateAuthenticationForm()
        XCTAssertTrue(viewModel.isAuthenticationFormValid)
    }
    
    func testValidationWithInvalidEmail() {
        viewModel.email = "invalidemail"
        viewModel.password = "password123"
        viewModel.validateAuthenticationForm()
        XCTAssertFalse(viewModel.isAuthenticationFormValid)
    }
    
    func testValidationWithShortPassword() {
        viewModel.email = "test@example.com"
        viewModel.password = "pass"
        viewModel.validateAuthenticationForm()
        XCTAssertFalse(viewModel.isAuthenticationFormValid)
    }
}

class QuizViewControllerTests: XCTestCase {
    func testRightAnswerAndFalseAnswers() {
        // Given
        let viewController = QuizViewController()
        
        // When
        // Then
        XCTAssertFalse(viewController.falseAnswers.contains(viewController.rightAnswer),
                       "Right answer should not be equal to any of the false answers")
        
    }
    
    func testPassedLevel() {
        let viewController = QuizViewController()
        
        // When
        viewController.currentLetter = 1
        viewController.passCurrentLetter(viewController.currentLetter)
        
        // Then
        XCTAssertEqual(viewController.currentLetter, 2)
    }
    
    func testGenerateUniqueRandomNumbers() {
        // Given
        let quizViewController = QuizViewController()
        quizViewController.currentLetter = 5 // Set currentLetter to any value
        
        // When
        let result = quizViewController.generateUniqueRandomNumbers()
        
        // Then
        XCTAssertEqual(result.count, 3, "Generated set should have 3 elements")
        XCTAssertFalse(result.contains(quizViewController.currentLetter),
                       "Generated set should not contain currentLetter")
        XCTAssertTrue(Set(0...42).isSuperset(of: result),
                      "Generated set should only contain numbers in range 0...42")
    }
    
    func testNextQuestion() {
        // Given
        let quizViewController = QuizViewController()
        quizViewController.currentLetter = 5
        quizViewController.currentQuestion = 2
        
        // When
        quizViewController.tappedNextButton()
        
        // Then
        XCTAssertEqual(quizViewController.currentQuestion, 3)
        XCTAssertEqual(quizViewController.questionIndicatorLabel.text, "3/5")
        XCTAssertTrue(quizViewController.nextButton.isHidden)
        XCTAssertLessThan(quizViewController.rightAnswer, 4)
    }
    
    func testNextLastQuestion() {
        // Given
        let quizViewController = QuizViewController()
        quizViewController.currentLetter = 5
        quizViewController.currentQuestion = 5
        
        // When
        quizViewController.tappedNextButton()
        
        // Then
        XCTAssertEqual(quizViewController.currentQuestion, 5)
        XCTAssertEqual(quizViewController.questionIndicatorLabel.text, "5/5")
    }
}

class LeaderboardViewControllerTests: XCTestCase {
    func testNotFetchedUser() {
        // Given
        let leaderboardViewController = LeaderboardViewController()
        
        // When
        
        // Then
        XCTAssertEqual(leaderboardViewController.users.count, 0)
    }
    
    func testFetchedUser() {
        // Given
        let leaderboardViewController = LeaderboardViewController()

        // When
        leaderboardViewController.fetchUsers()
        
        // Then
        XCTAssertNotNil(leaderboardViewController.users)
    }
    
}
