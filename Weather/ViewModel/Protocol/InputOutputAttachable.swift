//
//  InputOutputAttachable.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Combine

protocol InputOutputAttachable {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
    
    func transform()
}

protocol DefaultInput {
    var fetchData: PassthroughSubject<Void, Never> { get set }
}

protocol WeatherInput {
    var fetchData: PassthroughSubject<GeoCoordinate, Never> { get set }
}
