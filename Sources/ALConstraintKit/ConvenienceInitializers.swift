//
//  ConvenienceInitializerz.swift
//  ALConstraintKit
//
//  Created by Francesco Bianco on 17/12/2019.
//  Copyright © 2019 Francesco Bianco. All rights reserved.
//

import Foundation
#if canImport(UIKit)

public extension UIView {
    /// Adds a series of suibviews to this view. (Note: The order in which the subviews are added will be used for the z axis)
    /// - Parameter subviews: The list of subviews that will be added.
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { (view) in
            self.addSubview(view)
        }
    }
}

public extension UIView {
    /// Initializes a view specifying the amount for the corner radius and optionally the background color.
    /// - Parameters:
    ///   - cornerRadius: The amount of corner radius.
    ///   - backgroundColor: The background color to apply to this view.
    convenience init(cornerRadius: CGFloat,
                     backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = cornerRadius
    }
    convenience init(tamic: Bool = false, backgroundColor: UIColor = .clear) {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = tamic
        self.backgroundColor = backgroundColor
    }
}

public extension UILabel {
    @available(iOS 13.0, *)
    convenience init(text: String = "",
                     textStyle: UIFont.TextStyle =  .body,
                     textColor: UIColor = .label,
                     textAlignment: NSTextAlignment = .center) {
        self.init(frame: .zero)
        self.text = text
        self.textAlignment = textAlignment
        self.font = UIFont.preferredFont(forTextStyle: textStyle)
    }
    /// Initialize a label with attributed text.
    /// - Parameter attributedText: The NSAttributedString describing the attributed text to display.
    convenience init(attributedText: NSAttributedString) {
        self.init(frame: .zero)
        self.attributedText = attributedText
    }
}

#endif
