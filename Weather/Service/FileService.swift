//
//  FileService.swift
//  Weather
//
//  Created by Junho Yoon on 9/13/24.
//

import Foundation

final class FileService {
    static let shared = FileService()
    
    private init() { }
    
    func loadJSONFromFile(filename: String) -> Data? {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            print("File not found: \(filename).json")
            return nil
        }
        
        do {
            return try Data(contentsOf: url)
        } catch {
            print("Error loading file: \(error)")
            return nil
        }
    }
    
    func parse<T: Decodable>(data: Data, modelType: T.Type) -> T? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(modelType, from: data)
            return decodedData
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
