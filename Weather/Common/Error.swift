//
//  Error.swift
//  Weather
//
//  Created by Junho Yoon on 9/16/24.
//

import Foundation

enum FileError: Error, LocalizedError {
    case fileNotFound
    case parsingFailed
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "File not found."
        case .parsingFailed:
            return "Failed to parse city list."
        }
    }
}
