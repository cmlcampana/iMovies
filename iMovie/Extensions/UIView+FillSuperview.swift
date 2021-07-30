//
//  UIView+FillSuperview.swift
//  iMovie
//
//  Created by Camila Campana on 29/07/21.
//

import UIKit
import SnapKit

extension UIView {
    public func fillSuperviewToSafeArea() {
        guard let superview = self.superview else { return }
     
        self.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(superview.safeAreaLayoutGuide.snp.bottomMargin)
                make.top.equalTo(superview.safeAreaLayoutGuide.snp.topMargin)
                make.leading.equalTo(superview.safeAreaLayoutGuide.snp.leadingMargin)
                make.trailing.equalTo(superview.safeAreaLayoutGuide.snp.trailingMargin)

             } else {
                make.edges.equalToSuperview()
             }
        }
    }
}
