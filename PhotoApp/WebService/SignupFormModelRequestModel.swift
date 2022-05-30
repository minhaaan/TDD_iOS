//
//  SignupFormModelRequestModel.swift
//  PhotoApp
//
//  Created by 최민한 on 2022/05/31.
//

import Foundation

struct SignupFormModelRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
