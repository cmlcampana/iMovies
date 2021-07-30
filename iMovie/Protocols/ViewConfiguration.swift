//
//  ViewConfiguration.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit

public protocol ViewConfiguration: UIView {
    func setupView()
    func buildViewHierarchy()
    func setupConstraints()
    func additionalSetup()
}

public extension ViewConfiguration {
    func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        buildViewHierarchy()
        setupConstraints()
        additionalSetup()
    }
    
    func additionalSetup() { }
}
