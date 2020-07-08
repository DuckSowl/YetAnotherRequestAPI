//
//  URLRequest+Init.swift
//  
//
//  Created by Anton Tolstov on 08.07.2020.
//

import Foundation

extension URLRequest {
    init?(with url: URL, httpMethod: HTTPMethod, headers: Headers? = nil,
         parameters: Parameters? = nil) {
        
        var urlComponents = URLComponents(string: url.absoluteString)
        urlComponents?.queryItems = parameters
        guard let url = urlComponents?.url else { return nil }
        self.init(url: url)
        
        self.httpMethod = httpMethod.name
        headers?.forEach { addValue($0, forHTTPHeaderField: $1) }
    }
    
    mutating func addJSONHeader() {
        self.addValue("application/json", forHTTPHeaderField: "Accept")
        self.addValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
