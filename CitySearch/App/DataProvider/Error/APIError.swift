//
//  APIError.swift
//  CitySearch
//
//  Created by Abhishek Verma on 23/02/2022.
//

import Foundation

public enum APIError: Error {
    case parse
    case network
    case fileNotFound
    case empty

    var localizedDescription: String {
        switch self {
        case .parse:
            return "Parsing Failed"
        case .network:
            return "Network Error"
        case .fileNotFound:
            return "File Not Found"
        case .empty:
            return "No data"
        }
    }
    
}
