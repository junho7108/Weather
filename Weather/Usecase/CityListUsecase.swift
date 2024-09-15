//
//  CityListUsecase.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Combine

struct CityListUsecase {
    private let repository: CityListRepositoryType
    
    init(repository: CityListRepositoryType) {
        self.repository = repository
    }
    
    func fetchCityList() -> AnyPublisher<[City], Error> {
        return self.repository.fetchCityList()
    }
}
