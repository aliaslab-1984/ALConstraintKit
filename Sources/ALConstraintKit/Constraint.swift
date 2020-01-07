//
//  Constraint.swift
//  ALConstraintKit
//
//  Created by Francesco Bianco on 17/12/2019.
//  Copyright © 2019 Francesco Bianco. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
public extension NSLayoutXAxisAnchor {
    @discardableResult
    func anchor(to match: NSLayoutXAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint

        constraint = self.constraint(equalTo: match,
                                     constant: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }
    ///Uses the same syntax used by NSLayoutConstraint API, in particular this method stretches the view's anchor to be less than or equal to the target view's anchor.
    @discardableResult
    func anchor(lessThanOrEqualto matchingAnchor: NSLayoutXAxisAnchor,
                        constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = self.constraint(lessThanOrEqualTo: matchingAnchor,
                                     constant: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }
}

public extension NSLayoutYAxisAnchor {
    @discardableResult
    func anchor(to match: NSLayoutYAxisAnchor, constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint

        constraint = self.constraint(equalTo: match,
                                     constant: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }
    ///Uses the same syntax used by NSLayoutConstraint API, in particular this method stretches the view's anchor to be less than or equal to the target view's anchor.
    @discardableResult
    func anchor(lessThanOrEqualto matchingAnchor: NSLayoutYAxisAnchor,
                        constant: CGFloat = 0) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        constraint = self.constraint(lessThanOrEqualTo: matchingAnchor,
                                     constant: constant)
        NSLayoutConstraint.activate([constraint])
        return constraint
    }
}
#endif
