//
//  SearchCityViewModel.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation
import Combine

final class SearchCityViewModel: ViewModelType {
    struct Input: DefaultInput {
        var fetchData: PassthroughSubject<Void, Never>
        var textDidChange: PassthroughSubject<String, Never>
    }
    
    struct Output {
        var cityList: [City]? = nil
    }
    
    struct Dependency { }
    
    var input: Input
    
    @Published var output: Output
    
    var dependency: Dependency? = nil
    
    var coordinator: any CoordinatorType
    
    let usecase: CityListUsecase
    
    var cancellables: Set<AnyCancellable> = .init()
    
    private var originalCityList: [City]?
    
    init(usecase: CityListUsecase, coordinator: Coordinator) {
        self.usecase = usecase
        
        self.coordinator = coordinator
        
        self.input = Input(fetchData: PassthroughSubject<Void, Never>(),
                           textDidChange: PassthroughSubject<String, Never>())
        
        self.output = Output(cityList: [])
        
        transform()
        
        defer {
            self.input.fetchData.send(())
        }
    }
    
    func transform() {
        input.fetchData
            .flatMap { [unowned self] in usecase.fetchCityList() }
            .map { $0 as [City] }
            .catch { _ in Just(nil) }
            .sink { [weak self] cityList in
                
                self?.originalCityList = cityList
                self?.output.cityList = cityList
            }
            .store(in: &cancellables)
        
        input.textDidChange
            .sink { [weak self] text in
                guard let self else { return }
                self.output.cityList = filterCities(cityList: originalCityList,
                                                    searchText: text)
            }
            .store(in: &cancellables)
    }
}

private extension SearchCityViewModel {
    func filterCities(cityList: [City]?, searchText: String) -> [City]? {
        
        guard let cityList,
              !searchText.isEmpty else { return cityList }
        
        let lowercasedSearchText = searchText.lowercased()
        
        return cityList.filter { city in
            city.name.lowercased().contains(lowercasedSearchText) ||
            city.country.lowercased().contains(lowercasedSearchText)
        }
    }
}
