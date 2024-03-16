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
    
    func testPressNextQuestion() {
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
    
    func testPressNextLastQuestion() {
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

class StagesViewCellTests: XCTestCase {
    // by default only level 0 is available, others are locked
    func testButtonDisabledDefaultCase() {
        let view = StagesViewCell()
        view.configureButton(with: 4)
        XCTAssertFalse(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, 0)
    }
    
    // 17%8 = 1 => case 1 or 3
    func testButtonDisabledCase1And3() {
        let view = StagesViewCell()
        view.configureButton(with: 17)
        XCTAssertFalse(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, 65)
    }
    
    // 18%8 = 2 => case 2
    func testButtonDisabledCase2() {
        let view = StagesViewCell()
        view.configureButton(with: 18)
        XCTAssertFalse(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, 85)
    }
    
    // 21%8 = 5 => case 5 or 7
    func testButtonDisabledCase5And7() {
        let view = StagesViewCell()
        view.configureButton(with: 21)
        XCTAssertFalse(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, -65)
    }
    
    // 22%8 = 6 => case 6
    func testButtonDisabledCase6() {
        let view = StagesViewCell()
        view.configureButton(with: 22)
        XCTAssertFalse(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, -85)
    }
    
    func testButtonEnabledDefaultCase() {
        LevelAccessManager.currentLevel = 1
        LevelAccessManager.shared.unlockLevelAccess()
        let view = StagesViewCell()
        view.configureButton(with: 0)
        XCTAssertTrue(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, 0)
    }
    
    // 11%8 = 3
    func testButtonEnabledCase1And3() {
        LevelAccessManager.currentLevel = 11
        LevelAccessManager.shared.unlockLevelAccess()
        let view = StagesViewCell()
        view.configureButton(with: 11)
        XCTAssertTrue(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, 65)
    }
    
    // 10%8 = 2
    func testButtonEnabledCase2() {
        LevelAccessManager.currentLevel = 11
        LevelAccessManager.shared.unlockLevelAccess()
        let view = StagesViewCell()
        view.configureButton(with: 10)
        XCTAssertTrue(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, 85)
    }
    
    // 15%8 = 7
    func testButtonEnabledCase5And7() {
        LevelAccessManager.currentLevel = 15
        LevelAccessManager.shared.unlockLevelAccess()
        let view = StagesViewCell()
        view.configureButton(with: 15)
        XCTAssertTrue(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, -65)
    }
    
    // 14%8 = 6
    func testButtonEnabledCase6() {
        LevelAccessManager.currentLevel = 14
        LevelAccessManager.shared.unlockLevelAccess()
        let view = StagesViewCell()
        view.configureButton(with: 14)
        XCTAssertTrue(view.stageButton.isEnabled)
        XCTAssertEqual(view.levelOffset, -85)
    }
}

class ProfileDataFormViewViewModelTests: XCTestCase {
    func firstScenario() {
        // Given
        let model = ProfileDataFormViewViewModel()
        
        // When
        model.fullName = "Rustem" // True
        model.username = "milka999" // True
        model.imageData = AppImage.errorIcon.uiImage // True
        model.validateUserProfileForm()
        
        // Then
        XCTAssertTrue(model.isFormValid)
    }
    
    func secondScenario() {
        // Given
        let model = ProfileDataFormViewViewModel()
        
        // When
        model.fullName = "R" // False
        model.username = "milka999" // True
        model.imageData = AppImage.errorIcon.uiImage // True
        model.validateUserProfileForm()
        
        // Then
        XCTAssertFalse(model.isFormValid)
    }
    
    func thirdScenario() {
        // Given
        let model = ProfileDataFormViewViewModel()
        
        // When
        model.fullName = "Rustem" // True
        model.username = "m" // False
        // model.imageData = AppImage.errorIcon.uiImage // False
        model.validateUserProfileForm()
        
        // Then
        XCTAssertFalse(model.isFormValid)
    }
}
