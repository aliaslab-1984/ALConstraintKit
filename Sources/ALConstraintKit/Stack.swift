//
//  HorizontalStack.swift
//  ALConstraintKit
//
//  Created by Francesco Bianco on 06/12/2019.
//  Copyright © 2019 Francesco Bianco. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
/// Helper class that handles the creation of an Horizontal or Vertical Stack of Views
public class ALConstraintMaker {
    
    ///Shorter name for UIStackView
    public typealias Stack = UIStackView
    /// Skips the verbose setup for a UIStackView
    /// - Parameters:
    ///   - axis: Determines the axis in which you want to place the items
    ///   - views: The list of view you want to stack.
    ///            **NOTE** The order in which are inserted will be the order in which are displayed.
    ///   - alignment: The alignment of each object inside the stack.
    ///   - distribution: The way in which each item in the stack expands.
    public static func makeStack(axis: NSLayoutConstraint.Axis = .vertical,
                                 views: [UIView] = [] ,
                                 alignment: Stack.Alignment = .center,
                                 distribution: Stack.Distribution = .equalSpacing) -> Stack {
        let container: Stack = UIStackView(arrangedSubviews: views)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.axis = axis
        container.distribution = distribution
        container.alignment = alignment
        return container
    }
    /// Skips the verbose setup for a UIStackView. Alternative constructor that don't need the list of views to stack.
    /// - Parameters:
    ///   - axis: Determines the axis in which you want to place the items
    ///   - alignment: The alignment of each object inside the stack.
    ///   - distribution: The way in which each item in the stack expands.
    public static func makeStack(axis: NSLayoutConstraint.Axis = .vertical,
                                 alignment: Stack.Alignment = .center,
                                 distribution: Stack.Distribution = .equalSpacing) -> Stack {
        return makeStack(axis: axis, views: [], alignment: alignment, distribution: distribution)
    }
    
    public static func hStack(alignment: Stack.Alignment = .center,
                              distribution: Stack.Distribution = .equalSpacing) -> Stack {
        return makeStack(axis: .horizontal, alignment: alignment, distribution: distribution)
    }
    
    public static func vStack(alignment: Stack.Alignment = .center,
                              distribution: Stack.Distribution = .equalSpacing) -> Stack {
        return makeStack(axis: .vertical, alignment: alignment, distribution: distribution)
    }
}

#endif
