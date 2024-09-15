//
//  CoordinatorTransitable.swift
//  Weather
//
//  Created by Junho Yoon on 9/15/24.
//

import SwiftUI

protocol CoordinatorTransitable: ObservableObject {
    var path: NavigationPath { get set }
    
    func push(_ scene: AppScene)
    func pop()
    func popToRoot()
}

extension CoordinatorTransitable {
    func push(_ scene: AppScene) {
        path.append(scene)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
