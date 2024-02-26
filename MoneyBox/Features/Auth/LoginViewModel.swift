//
//  LoginViewModel.swift
//  MoneyBox
//
//  Created by Glenn Ludszuweit on 26.02.24.
//

import UIKit
import Networking

actor AppUser {
    static var user: LoginResponse.User?
}

final class LoginViewModel: LoginViewModelProtocol {
    private let dataProvider: DataProvider
    private let sessionManager: SessionManager
    
    init(dataProvider: DataProvider = DataProvider(), sessionManager: SessionManager = SessionManager()) {
        self.dataProvider = dataProvider
        self.sessionManager = sessionManager
    }
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let isUserValid = validateUser(email: email, pass: password)
        
        guard isUserValid else {
            return
        }
        
        let loginRequest = LoginRequest(email: email, password: password)
        
        dataProvider.login(request: loginRequest) { result in
            switch result {
            case let .success(response):
                let token = response.session.bearerToken
                self.sessionManager.setUserToken(token)
                AppUser.user = response.user
                completion(.success(()))
            case let .failure(error):
                // TODO: HANDLE THE ERROR
                completion(.failure(error))
                break
            }
        }
    }
    
    func validateUser(email: String?, pass: String?) -> Bool {
        guard email != nil else { return false }
        guard pass != nil else { return false }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let isEmailValid = emailPredicate.evaluate(with: email)
        let isPassValid = pass!.count >= 8
        
        if isEmailValid && isPassValid {
            return true
        } else {
            return false
        }
    }
}
