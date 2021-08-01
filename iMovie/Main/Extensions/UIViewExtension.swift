//
//  UIViewExtension.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit

extension UIView {
    public func fillSuperviewToSafeArea() {
        guard let superview = self.superview else { return }
     
        self.constraint {if #available(iOS 11.0, *) {
           return [
            $0.topAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.topAnchor),
            $0.leftAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leftAnchor),
            $0.rightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.rightAnchor),
            $0.bottomAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.bottomAnchor)
            ]
        } else {
           return [
            $0.topAnchor.constraint(equalTo: superview.topAnchor),
            $0.leftAnchor.constraint(equalTo: superview.leftAnchor),
            $0.rightAnchor.constraint(equalTo: superview.rightAnchor),
            $0.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            ]
        }}
    }
    
    func constraint(_ closure: (UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(closure(self))
    }
    
    func deactiveConstraint(_ closure: (UIView) -> [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.deactivate(closure(self))
    }

    func constraint(to container: UIView, margin: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin),
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin),
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin),
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin),
        ]
        NSLayoutConstraint.activate(constraints)
    }

    func constraint(to containerLayoutGuide: UILayoutGuide, margin: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.topAnchor.constraint(equalTo: containerLayoutGuide.topAnchor, constant: margin),
            self.bottomAnchor.constraint(equalTo: containerLayoutGuide.bottomAnchor, constant: -margin),
            self.leadingAnchor.constraint(equalTo: containerLayoutGuide.leadingAnchor, constant: margin),
            self.trailingAnchor.constraint(equalTo: containerLayoutGuide.trailingAnchor, constant: -margin),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
