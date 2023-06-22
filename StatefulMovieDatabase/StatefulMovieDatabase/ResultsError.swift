//
//  ResultsError.swift
//  StatefulMovieDatabase
//
//  Created by Milo Kvarfordt on 6/22/23.
//

import Foundation

enum ResultError: LocalizedError {
    
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case movieResponse
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server. Please try again."
        case .thrownError(let error):
            return "Error: \(error.localizedDescription) -> \(error)"
        case .noData:
            return "The server responded with no data. Please try again."
        case .unableToDecode:
            return "The server responded with bad data. Please try again."
        case .movieResponse:
            return "There was an error getting a response from the Movie"
        }
    }
}


