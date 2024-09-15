//
//  CoordinatorType.swift
//  Weather
//
//  Created by Junho Yoon on 9/16/24.
//

import Foundation

protocol CoordinatorType: CoordinatorTransitable {
    var initialScene: AppScene { get set }
}
