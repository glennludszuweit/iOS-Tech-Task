//
//  LoginViewModelTests.swift
//  MoneyBoxTests
//
//  Created by Glenn Ludszuweit on 26.02.24.
//

import XCTest
@testable import MoneyBox

class LoginViewModelTests: XCTestCase {
    var viewModel: LoginViewModelProtocol!
    
    override func setUp() {
        super.setUp()
        viewModel = LoginViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testValidLogin() {
        let expectation = self.expectation(description: "Valid Login")
        
        viewModel.login(email: "test@example.com", password: "password") { result in
            switch result {
            case .success:
                XCTAssertTrue(true) // Login succeeded
            case .failure:
                XCTFail("Login should succeed with valid credentials")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testInvalidLogin() {
        let expectation = self.expectation(description: "Invalid Login")
        
        viewModel.login(email: "invalidemail", password: "password") { result in
            switch result {
            case .success:
                XCTFail("Login should fail with invalid credentials")
            case .failure:
                XCTAssertTrue(true) // Login failed as expected
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testValidateUserWithValidInput() {
        let isValid = viewModel.validateUser(email: "test@example.com", pass: "password")
        XCTAssertTrue(isValid, "Validation should succeed with valid input")
    }
    
    func testValidateUserWithInvalidEmail() {
        let isValid = viewModel.validateUser(email: "invalidemail", pass: "password")
        XCTAssertFalse(isValid, "Validation should fail with invalid email")
    }
    
    func testValidateUserWithShortPassword() {
        let isValid = viewModel.validateUser(email: "test@example.com", pass: "pass")
        XCTAssertFalse(isValid, "Validation should fail with short password")
    }
}

