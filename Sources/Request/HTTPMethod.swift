//
//  HTTPMethod.swift
//
//
//  Created by Anton Tolstov on 06.07.2020.
//


public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
    
    var name: String { rawValue.uppercased() }
}
