//
//  SignUpWebService.swift
//  PhotoApp
//
//  Created by 최민한 on 2022/05/31.
//

import Foundation

class SignUpWebService {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signUp(withForm formModel: SignupFormModelRequestModel, completionHandler: @escaping(SignupResponseModel?, SignupErrors?) -> Void) {
        guard let url = URL(string: urlString) else {
            // TODO: Create a unit test to test that a specific error message return
            completionHandler(nil, .invalidRequestURLStringError)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        urlSession.dataTask(with: request) { data, response, error in
            // TODO: Write a new unit test to handle and error here.
            
            if let data = data, let signUpResponseModel = try? JSONDecoder().decode(SignupResponseModel.self, from: data) {
                completionHandler(signUpResponseModel, nil)
            } else {
                // TODO: Create a unit test to test that a specific error message return
                completionHandler(nil, .responseModelParsingError)
            }
        }.resume()
    }
}
