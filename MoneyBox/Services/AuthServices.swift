//
//  AuthServices.swift
//  MoneyBox
//
//  Created by Glenn Ludszuweit on 26.02.24.
//

import Foundation

protocol LoginViewModelProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
    func validateUser(email: String?, pass: String?) -> Bool
}
