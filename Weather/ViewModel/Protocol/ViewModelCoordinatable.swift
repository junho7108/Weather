//
//  ViewModelCoordinatable.swift
//  Weather
//
//  Created by Junho Yoon on 9/14/24.
//

import Combine

protocol ViewModelCoordinatable {
    var coordinator: any CoordinatorTransitable { get set }
}

