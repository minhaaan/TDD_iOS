//
//  SignupFormModelValidator.swift
//  PhotoAppTests
//
//  Created by 최민한 on 2022/05/29.
//

import XCTest
@testable import PhotoApp

class SignupFormModelValidatorTests: XCTestCase {
    
    var sut: SignupFormModelValidator!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SignupFormModelValidator()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testSignUpFormModelValidator_WhenValidFirstNameProvided_ShouldReturnTrue() {
        
        // Arrange
        
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "minan")
        
        // Assert
        XCTAssertTrue(isFirstNameValid)
    }
    
    func testSignUpFormModelValidator_WhenTooShortFirstNameProvided_ShouldReturnFalse() {
        
        // Arrange

        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "S")
        
        // Assert
        XCTAssertFalse(isFirstNameValid)
        
    }
    
    func testSignUpFormModelValidator_WhenEmptytFirstNameProvided_ShouldReturnFalse() {
        // Arrange
        
        
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "")
        
        // Assert
        XCTAssertFalse(isFirstNameValid)
    }
    
    func testSignUpFormModelValidator_WhenTooLongFirstNameProvided_ShouldReturnFalst() {
        
        // Act
        let isFirstNameValid = sut.isFirstNameValid(firstName: "asdsakldjsakldjsakd")
        
        // Assert
        XCTAssertFalse(isFirstNameValid)
    }
    
    func testSignUpFormModelValidator_WhenEqualPassword_True() {
        
        // Act
        let doPasswordMatch = sut.doPasswordMatch(password: "12345678", repeatPassword: "12345678")
        
        // Assert
        XCTAssertTrue(doPasswordMatch)
    }
    
    func testSignUpFormModelValidator_WhenNotEqualPassword_False() {
        
        // Act
        let doPasswordMatch = sut.doPasswordMatch(password: "12345644", repeatPassword: "12345678")
        
        // Assert
        XCTAssertFalse(doPasswordMatch)
    }
    
    func testSignUpFormModelValidator_TooShortAndLongPassword_False() {
        
        // Act
        let doPasswordMatch = sut.isPasswordValid(password: "1")
        let longCase = sut.isPasswordValid(password: "12321312312312321")
        
        // Assert
        XCTAssertFalse(doPasswordMatch)
        XCTAssertFalse(longCase)
    }

}
