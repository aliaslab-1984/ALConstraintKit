//
//  CustomPadding.swift
//  ALConstraintKit
//
//  Created by Francesco Bianco on 06/12/2019.
//  Copyright © 2019 Francesco Bianco. All rights reserved.
//

#if canImport(UIKit)
import UIKit
public extension UIEdgeInsets {
    /// Enumeration to describe both the Horizontal and the Vertical axis.
    enum Axis {
        case horizontal(left: CGFloat, right: CGFloat)
        case vertical(top: CGFloat, bottom: CGFloat)
    }
    
    @available(*, deprecated, message: "Instead use init(_ edges: [Edge], value: CGFloat) or init(_ edges: [Edge: CGFloat]) initializers")
    /// Initializes the edge insets using only one axis insetead of specifying all the possible sides.
    init(axis: Axis) {
        self.init(top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0)
        switch axis {
        case let .vertical(top, bottom):
            self.top = top
            self.bottom = bottom
            self.left = 0
            self.right = 0
        case let .horizontal(left, right):
            self.top = 0
            self.bottom = 0
            self.left = left
            self.right = right
        }
    }
    ///Initialize the padding applied to all the 4 edges with one equal value
    init(all: CGFloat) {
        self.init(top: all,
                  left: all,
                  bottom: all,
                  right: all)
    }
    /// Initializes the edge insets using a dictionary of values for each edge.
    /// It's possible to use the .vertical, .horizontal or .all keyword to apply the same amount of padding to all the horizontal, vertical or to all the edges.
    init(_ edges: [Edge: CGFloat]) {
        if edges.keys.contains(.all) {
            if let value = edges[.all] {
                self.init(top: value,
                          left: value,
                          bottom: value,
                          right: value)
                return
            }
        }
        self.init(top: 0,
                  left: 0,
                  bottom: 0,
                  right: 0)
        
        for edge in edges {
            switch edge.key {
            case .top:
                self.top = edge.value
            case .bottom:
                self.bottom = edge.value
            case .left:
                self.left = edge.value
            case .right:
                self.right = edge.value
            case .vertical:
                self.top = edge.value
                self.bottom = edge.value
            case .horizontal:
                self.left = edge.value
                self.right = edge.value
            case .all:
                self.left = edge.value
                self.right = edge.value
                self.top = edge.value
                self.bottom = edge.value
            }
        }
    }
    /// Initializes the edge insets using an array of edges.
    /// It's possible to use the .vertical, .horizontal or .all keyword to apply the same amount of padding to all the horizontal, vertical or to all the edges.
    init(_ edges: [Edge],
         constant: CGFloat) {
        self.init(top: 0, left: 0, bottom: 0, right: 0)
        
        for edge in edges {
            switch edge {
            case .top:
                self.top = constant
            case .bottom:
                self.bottom = constant
            case .left:
                self.left = constant
            case .right:
                self.right = constant
            case .vertical:
                self.top = constant
                self.bottom = constant
            case .horizontal:
                self.right = constant
                self.left = constant
            case .all:
                self.right = constant
                self.left = constant
                self.top = constant
                self.bottom = constant
            }
        }
    }
    /// Abstraction to describe each edge of a rectangle.
    enum Edge: CaseIterable {
        case top
        case bottom
        case left
        case right
        case vertical
        case horizontal
        case all
    }
}
#endif
