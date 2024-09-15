//
//  ViewModelType.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Combine

protocol ViewModelType: ObservableObject,
                        InputOutputAttachable,
                        DependeciesAttachable,
                        ViewModelCoordinatable {
    
    var cancellables: Set<AnyCancellable> { get }
}
