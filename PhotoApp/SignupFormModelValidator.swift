//
//  SignupFormModelValidator.swift
//  PhotoApp
//
//  Created by 최민한 on 2022/05/29.
//

import Foundation

class SignupFormModelValidator {
//    let firstName: String
    
    func isFirstNameValid(firstName: String) -> Bool {
        var returnValue = true
        
        if firstName.isEmpty {
            returnValue = false
        }
        if firstName.count < SignUpConstants.firstNameMinLength || firstName.count > SignUpConstants.firstNameMaxLength {
            returnValue = false
        }
        
        return returnValue
    }
    
    func doPasswordMatch(password: String, repeatPassword: String) -> Bool {
        return password == repeatPassword
    }
    
    func isPasswordValid(password: String) -> Bool {
        return password.count >= 2 && password.count <= 10 
    }
    
}
