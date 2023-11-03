//
//  ApiError.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 31/10/2023.
//

import Foundation

enum APIError: String, Error {
    case internalError = "internalError"
    case serverError = "serverError"
    case parsingError = "parsingError"
    case urlBadFormmated = "urlBadFormmated"
    case unknownError = "unknownError"
    case errorDecoding = "errorDecoding"
}
