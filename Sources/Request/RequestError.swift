//
//  RequestError.swift
//
//
//  Created by Anton Tolstov on 08.07.2020.
//


public enum RequestError: Error {
    case urlCreationError
    case networkError(error: Error)
    case missingData
    case decodingError
    case canceled
}

import Foundation
