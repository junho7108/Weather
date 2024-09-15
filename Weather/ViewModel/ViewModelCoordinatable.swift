//
//  ViewModelCoordinatable.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Combine

protocol DefaultCoordinate {
    var close: PassthroughSubject<Void, Never> { get set }
}

protocol DefaultCoordinatable {
    var coordinate: DefaultCoordinate { get }
}

protocol ViewModelCoordinatable {
    associatedtype Coordinate: DefaultCoordinate
    var coordinate: Coordinate { get set }
}

extension ViewModelCoordinatable {
    var coordinatoe: DefaultCoordinate { return self.coordinate }
}
