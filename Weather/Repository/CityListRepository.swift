//
//  CityListRepository.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Combine

protocol CityListRepositoryType {
    func fetchCityList() -> AnyPublisher<[City], Error>
}

struct CityListRepository: CityListRepositoryType {
    func fetchCityList() -> AnyPublisher<[City], Error> {
            Future<[City], Error> { promise in
                if let jsonData = FileService.shared.loadJSONFromFile(filename: "citylist") {
                    if let cities = FileService.shared.parse(data: jsonData, modelType: [City].self) {
                        promise(.success(cities))
                    } else {
                        promise(.failure(FileError.parsingFailed))
                    }
                } else {
                    promise(.failure(FileError.fileNotFound))
                }
            }
            .eraseToAnyPublisher()
        }
}
