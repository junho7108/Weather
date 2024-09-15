//
//  SearchCityViewModel.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import Foundation
import Combine

final class SearchCityViewModel: ViewModelType {
    struct Input {
        var fetchData: PassthroughSubject<Void, Never>
    }
    
    struct Output {
        var cityList: [City]? = nil
    }
    
    var input: Input
    
    @Published var output: Output
    
    var coordinator: any CoordinatorTransitable
    
    let usecase: CityListUsecase
    
    var cancellables: Set<AnyCancellable> = .init()
    
    init(usecase: CityListUsecase, coordinator: Coordinator) {
        self.usecase = usecase
        
        self.coordinator = coordinator
        
        self.input = Input(fetchData: PassthroughSubject<Void, Never>())
        
        self.output = Output(cityList: [])
        
        transform()
    }
    
    func transform() {
        input.fetchData
            .flatMap { [unowned self] in usecase.fetchCityList() }
            .map { $0 as [City] }
            .catch { _ in Just(nil) }
            .sink { [weak self] cityList in
                self?.output.cityList = cityList
                print("City \(cityList)")
            }
            .store(in: &cancellables)
    }
}
