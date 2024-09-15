//
//  DateFormatterProtocol.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation

protocol DateFormatterProtocol {
    func formatDateString(_ dateString: String) -> String?
}

extension DateFormatterProtocol {
    func convertUTCToKST(utcDateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let utcDate = inputFormatter.date(from: utcDateString) else {
            return nil
        }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        outputFormatter.timeZone = TimeZone(abbreviation: "KST")
        
        return outputFormatter.string(from: utcDate)
    }
    
    func formatDateString(_ dateString: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = inputFormatter.date(from: dateString) else { return nil }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "a h시"
        let formattedString = outputFormatter.string(from: date)
        
        let localizedString = formattedString
            .replacingOccurrences(of: "AM", with: "오전")
            .replacingOccurrences(of: "PM", with: "오후")
        
        return localizedString
    }
}
