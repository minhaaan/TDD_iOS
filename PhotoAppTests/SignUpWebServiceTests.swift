import XCTest
@testable import PhotoApp

class SignUpWebServiceTests: XCTestCase {
    
    override class func setUp() {
        
    }
    
    override class func tearDown() {
    
    }
    
    func testSignupWebService_WhenGivenSuccessfullResponse_ReturnSuccess() {
        // Given
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        let urlSession = URLSession(configuration: config)
        let jsonString = "{\"status\":\"ok\"}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let sut = SignUpWebService(urlString: SignUpConstants.signupURLString, urlSession: urlSession)
        
        let signFormRequestModel = SignupFormModelRequestModel(
            firstName: "minan",
            lastName: "zian",
            email: "minan@test.com",
            password: "12345678"
        )
        
        let expectation = self.expectation(description: "Signup Web Service Response Expectation")

        // When
        
        sut.signUp(withForm: signFormRequestModel) { (signUpResponseModel, error) in
            
            // Then
            // "{\"status\":\"ok\"}"
            XCTAssertEqual(signUpResponseModel?.status, "ok")
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testSignupWebService_WhenReveivedDiffrentJSONResponse_ErrorTookPlace() {
        // Given
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        let urlSession = URLSession(configuration: config)
        let jsonString = "{\"path\":\"users\", \"error\":\"Internal Server Error\"}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let sut = SignUpWebService(urlString: SignUpConstants.signupURLString, urlSession: urlSession)
        
        let signFormRequestModel = SignupFormModelRequestModel(
            firstName: "minan",
            lastName: "zian",
            email: "minan@test.com",
            password: "12345678"
        )
        
        let expectation = self.expectation(description: "Signup() method expectation for a response that contains a different JSON structure")

        // When
        
        sut.signUp(withForm: signFormRequestModel) { (signUpResponseModel, error) in
            
            // Then
            // "{\"status\":\"error\"}"
            XCTAssertNil(signUpResponseModel, "The response model for a request containing unknown JOSN response, should have been nil")
            XCTAssertEqual(error, SignupErrors.responseModelParsingError)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
        
    }
    
    func testSignupWebService_WhenEmptyURLStringProvided_ReturnError() {
        // Given
        
        let expectation = self.expectation(description: "빈 url")
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlProtocol.self]
        let urlSession = URLSession(configuration: config)
        let jsonString = "{\"path\":\"users\", \"error\":\"Internal Server Error\"}"
        MockUrlProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let sut = SignUpWebService(urlString: "")
        
        let signFormRequestModel = SignupFormModelRequestModel(
            firstName: "minan",
            lastName: "zian",
            email: "minan@test.com",
            password: "12345678"
        )
        
        // When
        
        sut.signUp(withForm: signFormRequestModel) { response, error in
            // Then
            XCTAssertEqual(error, .invalidRequestURLStringError)
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2)
        
    }
    
    
}
