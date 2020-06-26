//
//  ApiClient.swift
//  GitHubApp
//
//  Created by John Roque Jorillo on 6/26/20.
//  Copyright © 2020 JohnRoque Inc. All rights reserved.
//

import Foundation

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

protocol ApiClient {
    func execute<T>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>, Error>) -> Void) where T : Decodable
}

class ApiClientImpl: ApiClient {
    
    let urlSession: URLSession
    let apiLogger: ApiLoggerable?
    
    init(config: URLSessionConfiguration, logger: ApiLoggerable?) {
        urlSession = URLSession(configuration: config)
        self.apiLogger = logger
    }
    
    func execute<T>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>, Error>) -> Void) where T : Decodable {
        
        self.apiLogger?.log(request: request.urlRequest)
        
        let dataTask = self.urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            
             self.apiLogger?.log(data: data, response: response as? HTTPURLResponse, error: error)
            
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(NetworkRequestError(error: error)))
                return
            }
            
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                do {
                    let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(ApiParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)))
                }
            } else {
                completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
            }
        }
        dataTask.resume()
    }
    
}
