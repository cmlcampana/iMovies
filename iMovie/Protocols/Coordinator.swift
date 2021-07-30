//
//  Coordinator.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import Foundation

public protocol Coordinator {
    func start()
    func popView()
}

public extension Coordinator {
    func start() { }
    func popView() { }
}
