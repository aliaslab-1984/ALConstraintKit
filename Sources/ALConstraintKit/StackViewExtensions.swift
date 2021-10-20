//
//  StackViewExtensions.swift
//  MyIDSignMobileAttempt
//
//  Created by Francesco Bianco on 05/12/2019.
//  Copyright © 2019 Francesco Bianco. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
public extension UIStackView {
    /// Utility method that helps to remove all the arranged subviews inside a UIStackView.
    func safelyRemoveArrangedSubviews() {
        // Remove all the arranged subviews and save them to an array
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }
        // Deactive all constraints at once
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
    /// Utility method that helps to remove s subview inside a UIStackView.
    func safelyRemoveArrangedSubview(view: UIView) {
        self.removeArrangedSubview(view)
        // Deactive all constraints at once and removes from superview
        view.deatach()
    }
}
#endif
