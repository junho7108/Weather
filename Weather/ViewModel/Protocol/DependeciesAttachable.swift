//
//  DependeciesAttachable.swift
//  Weather
//
//  Created by Junho Yoon on 9/16/24.
//

import Foundation

protocol DependeciesAttachable {
    associatedtype Dependency

    var dependency: Dependency? { get set }
}
