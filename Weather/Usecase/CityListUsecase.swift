//
//  CityListUsecase.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Combine
import Dependencies

struct CityListUsecase {
    private let repository: CityListRepositoryType
    
    init(repository: CityListRepositoryType) {
        self.repository = repository
    }
    
    func fetchCityList() async -> Result<[City], Error> {
        return await self.repository.fetchCityList()
    }
    
    func fetchCityList() -> AnyPublisher<[City], Error> {
        return self.repository.fetchCityList()
    }
}

extension CityListUsecase: DependencyKey {
    static var liveValue: CityListUsecase = CityListUsecase(repository: CityListRepository())
}

extension DependencyValues {
    var cityListUsecase: CityListUsecase {
        get { self[CityListUsecase.self] }
        set { self[CityListUsecase.self] = newValue }
    }
}
