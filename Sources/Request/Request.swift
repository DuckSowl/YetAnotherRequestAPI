//
//  Request.swift
//
//
//  Created by Anton Tolstov on 06.07.2020.
//

import Foundation

// MARK: - Typealiases

public typealias Parameters = [URLQueryItem]
public typealias Headers = [String: String]
public typealias Response = Result<Data?, RequestError>

private typealias DataTask = URLSessionDataTask

public final class Request {
        
    // MARK: - Properties
    
    private let dataTask: DataTask? = nil
    private var completions = [(Response) -> ()]()
    private var response: Response? = nil {
        didSet {
            completions.forEach { $0(response!) }
        }
    }
    
    // MARK: - Initializers
    
    private init() { }
    
    @discardableResult
    public init(url: URL,
                httpMethod: HTTPMethod,
                headers: Headers? = nil,
                parameters: Parameters? = nil) {
        
        if let urlRequest = URLRequest(with: url,
                                       httpMethod: httpMethod,
                                       headers: headers,
                                       parameters: parameters) {
            self.startDataTask(urlRequest)
        } else {
            response = .failure(.urlCreationError)
        }
    }
    
    @discardableResult
    public convenience init(string: String,
                            httpMethod: HTTPMethod,
                            headers: Headers? = nil,
                            parameters: Parameters? = nil) {
        if let url = URL(string: string) {
            self.init(url: url, httpMethod: httpMethod,
                      headers: headers, parameters: parameters)
        } else {
            self.init()
            response = .failure(.urlCreationError)
        }
    }
    
    // MARK: - Short request syntax
    
    @discardableResult
    public static func get(url: URL,
                           headers: Headers? = nil,
                           parameters: Parameters? = nil) -> Request {
        Request(url: url, httpMethod: .get, headers: headers, parameters: parameters)
    }
    
    @discardableResult
    public static func get(string: String,
                           headers: Headers? = nil,
                           parameters: Parameters? = nil) -> Request {
        Request(string: string, httpMethod: .get, headers: headers, parameters: parameters)
    }
    
    @discardableResult
    public static func post(url: URL,
                            headers: Headers? = nil,
                            parameters: Parameters? = nil) -> Request {
        Request(url: url, httpMethod: .post, headers: headers, parameters: parameters)
    }
    
    @discardableResult
    public static func post(string: String,
                            headers: Headers? = nil,
                            parameters: Parameters? = nil) -> Request {
        Request(string: string, httpMethod: .post, headers: headers, parameters: parameters)
    }
    
    // MARK: - DataTask Manipulations

    public func cancel() {
        dataTask?.cancel()
        
        guard response == nil else {
            response = .failure(.canceled)
            return
        }
    }
    
    private func startDataTask(_ urlRequest: URLRequest) {
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                if (error! as NSError).code == NSURLErrorCancelled {
                    self.response = .failure(.canceled)
                } else {
                    self.response = .failure(.networkError(error: error!))
                }
                return
            }
            
            self.response = .success(data)
        }.resume()
    }
    
    // MARK: - Response
    
    @discardableResult
    public func response(completion: @escaping (Response) -> ()) -> Request {
        if let response = response {
            completion(response)
        } else {
            completions.append(completion)
        }
        return self
    }
}

