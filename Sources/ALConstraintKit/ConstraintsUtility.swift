//
//  ConstraintsUtility.swift
//  MyIDSignMobileAttempt
//
//  Created by Francesco Bianco on 04/12/2019.
//  Copyright © 2019 Francesco Bianco. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit

public extension UIView {
    
    /// Describes the set of vertical positions in which a view can be anchored
    enum VerticalAlignment {
        case top
        case bottom
        case center
    }
    
    /// Describes the set of horizontal positions in which a view can be anchored
    enum HorizontalAlignment {
        case left
        case right
        case center
    }
    
    /// Utility method that fills the superview with this view.
    /// - Parameter padding: If needed this paraeter can apply some spacing between the parent view and the view itself.
    /// - Parameter referredToSafeArea: Used to create a reference to specify if the constraint applied to a view must be applied referring to the safe area inset.
    func fillSuperview(padding: UIEdgeInsets = .zero,
                       referredToSafeArea: Bool = false) {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else { return }
        var constraints: [NSLayoutConstraint] = []
        if #available(iOS 11.0, *) {
            constraints = referredToSafeArea ? [
            self.topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor,
                                      constant: padding.top),
            self.bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor,
                                         constant: -padding.bottom),
            self.leadingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.leadingAnchor,
                                          constant: padding.left),
            self.trailingAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.trailingAnchor,
                                           constant: -padding.right)
                ] : [
                self.topAnchor.constraint(equalTo: superView.topAnchor,
                                          constant: padding.top),
                self.bottomAnchor.constraint(equalTo: superView.bottomAnchor,
                                             constant: -padding.bottom),
                self.leadingAnchor.constraint(equalTo: superView.leadingAnchor,
                                              constant: padding.left),
                self.trailingAnchor.constraint(equalTo: superView.trailingAnchor,
                                               constant: -padding.right)
                ]
        } else {
            constraints = [
            self.topAnchor.constraint(equalTo: superView.topAnchor,
                                      constant: padding.top),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor,
                                         constant: -padding.bottom),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor,
                                          constant: padding.left),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor,
                                           constant: -padding.right)
            ]
        }
        constraints.activate()
    }
    
    /// Utility method that fills the superview with this view, allgining the child view using layoutMargins guide.
    /// - Parameter padding: If needed this paraeter can apply some additional spacing between the parent view and the view itself.
    func fillSuperViewWithLayoutGuide(plusPadding: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {return}
        var constraints: [NSLayoutConstraint] = []
        
        constraints = [
            self.topAnchor.constraint(equalTo: superView.layoutMarginsGuide.topAnchor,
                                      constant: plusPadding.top),
            self.bottomAnchor.constraint(equalTo: superView.layoutMarginsGuide.bottomAnchor,
                                         constant: -plusPadding.bottom),
            self.leadingAnchor.constraint(equalTo: superView.layoutMarginsGuide.leadingAnchor,
                                          constant: plusPadding.left),
            self.trailingAnchor.constraint(equalTo: superView.layoutMarginsGuide.trailingAnchor,
                                           constant: -plusPadding.right)
        ]
        
        constraints.activate()
    }
    
    /// Describes the set of dimensions of a 2D object.
    enum Dimension {
        case width
        case height
    }
    
    /// Specifies one dimension for a view and the ratio that this dimension
    /// needs to have compared to the target view.
    /// - Parameters:
    ///   - dimension: the dimension for the view that needs to be caluclated (Width or Height)
    ///   - multiplier: The actual proportion needed for the dimension.
    ///   - target: The target view that we want to caluclate the proportion of.
    ///   - referredToSafeArea: whether the view should be placed reflecting the safe area insets or not.
    ///   - alignment: The horizontal alignment that has to be used.
    func specify(dimension: Dimension,
                 multiplier: CGFloat,
                 target: AnyArrangeable,
                 referredToSafeArea: Bool = false,
                 alignment: HorizontalAlignment = .center) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let targetView = target.viewToConstraint
        switch dimension {
        case .width:
            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([ referredToSafeArea ?
                    self.widthAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.widthAnchor,
                                                multiplier: multiplier) :
                    self.widthAnchor.constraint(equalTo: targetView.widthAnchor,
                                                multiplier: multiplier)
                ])
            } else {
                [self.widthAnchor.constraint(equalTo: targetView.widthAnchor,
                                             multiplier: multiplier)].activate()
            }
            applyHAlignment(superView: targetView,
                            alignment: alignment,
                            padding: .zero,
                            size: .zero).activate()
        case .height:
            if #available(iOS 11.0, *) {
                NSLayoutConstraint.activate([ referredToSafeArea ?
                                              self.heightAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.heightAnchor,
                                                                           multiplier: multiplier) :
                                                self.heightAnchor.constraint(equalTo: targetView.heightAnchor,
                                                                             multiplier: multiplier)
                                            ])
            } else {
                [self.heightAnchor.constraint(equalTo: targetView.heightAnchor,
                                              multiplier: multiplier)].activate()
            }
            applyHAlignment(superView: targetView,
                            alignment: alignment,
                            padding: .zero,
                            size: .zero).activate()
        }
    }
    /// Specifies only the size of a view.
    /// **NOTE** Both of the dimensions must be != 0
    /// - Parameter size: The desired size for the view.
    func specify(size: CGSize) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
        ]
        constraints.activate()
    }
    /// Given the size returns the corresponding NSLAyoutConstraint array that describes the size.
    /// - Parameter size: The desired size.
    private func returnConstraints(for size: CGSize) -> [NSLayoutConstraint] {
        if size.width != 0 && size.height != 0 {
            let constraints: [NSLayoutConstraint] = [
                self.widthAnchor.constraint(equalToConstant: size.width),
                self.heightAnchor.constraint(equalToConstant: size.height)
            ]
            return constraints
        } else if size.width == 0 && size.height != 0 {
            let constraints: [NSLayoutConstraint] = [self.heightAnchor.constraint(equalToConstant: size.height)]
            return constraints
        } else {
            let constraints: [NSLayoutConstraint] = [self.widthAnchor.constraint(equalToConstant: size.width)]
            return constraints
        }
    }
    /// Specifies one or both the dimensions of a view and activates the relative constraints.
    /// - Parameters:
    ///   - width: desired width
    ///   - height: desired height
    func specify(width: CGFloat?, height: CGFloat?) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let safeHeight = height {
            [self.heightAnchor.constraint(equalToConstant: safeHeight)].activate()
        }
        if let safeWidth = width {
            [self.widthAnchor.constraint(equalToConstant: safeWidth)].activate()
        }
    }
    
    /// Funciton that pins a specified view to a specific point of the superview.
    /// - Parameters:
    ///   - position: The vertical position in which the child view is going to be placed
    ///   - alignment: The horizontal position in which the child view will be placed
    ///   - padding: Custom spacing applied from the edges of the parent view
    ///   - size: the default is .zero. If you specify a width equal to zero or a height equal to zero
    ///           it will only apply the one which is != of zero.
    func pinTo(position: VerticalAlignment,
               alignment: HorizontalAlignment = .center,
               padding: UIEdgeInsets = .zero,
               size: CGSize = .zero,
               referredToSafeArea: Bool = false) {
        self.translatesAutoresizingMaskIntoConstraints = false
        guard let superView = superview else {return}

        var constraints: [NSLayoutConstraint] = []
        
        switch position {
        case .top:
            if #available(iOS 11.0, *) {
                constraints.append(self.topAnchor.constraint(equalTo:
                    referredToSafeArea ? superView.safeAreaLayoutGuide.topAnchor :
                        superView.topAnchor, constant: padding.top))
            } else {
                constraints.append(self.topAnchor.constraint(equalTo: superView.topAnchor,
                                                             constant: padding.top))
            }
        case .bottom:
            if #available(iOS 11.0, *) {
                constraints.append(self.bottomAnchor.constraint(equalTo:
                    referredToSafeArea ? superView.safeAreaLayoutGuide.bottomAnchor :
                        superView.bottomAnchor, constant: padding.top))
            } else {
                constraints.append(self.bottomAnchor.constraint(equalTo: superView.bottomAnchor,
                                                                constant: padding.top))
            }
        case .center:
            constraints.append(self.centerYAnchor.constraint(equalTo: superView.centerYAnchor))
        }
        NSLayoutConstraint.activate(constraints)
    }
    
    /// Mehod that handles the placement of the child view in the horizontal axis.
    /// - Parameters:
    ///   - superView: The superview of the child.
    ///   - alignment: The horizontal alignment of the child view
    ///   - padding: Custom spacing applied from the edges of the parent view
    ///   - size: The default is .zero. If you specify a width equal to zero or a height equal to zero
    ///           it will only apply the one which is != of zero.
    private func applyHAlignment(superView: UIView,
                                 alignment: HorizontalAlignment,
                                 padding: UIEdgeInsets,
                                 size: CGSize,
                                 referredToSafeArea: Bool = false) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        switch alignment {
        case .center:
            let baseContraints: [NSLayoutConstraint] = [
                self.centerXAnchor.constraint(equalTo: superView.centerXAnchor)]
            var plus: [NSLayoutConstraint] = []
            if #available(iOS 11.0, *) {
                plus = [
                    self.leadingAnchor.constraint(lessThanOrEqualTo:
                        referredToSafeArea ? superView.safeAreaLayoutGuide.leadingAnchor :
                            superView.leadingAnchor,
                            constant: padding.left),
                    self.trailingAnchor.constraint(equalTo:
                        referredToSafeArea ? superView.safeAreaLayoutGuide.trailingAnchor :
                        superView.trailingAnchor,
                        constant: -padding.right)
                ]
            } else {
                plus = [
                    self.leadingAnchor.constraint(lessThanOrEqualTo: superView.leadingAnchor,
                                                  constant: padding.left),
                    self.trailingAnchor.constraint(equalTo: superView.trailingAnchor,
                                                   constant: -padding.right)
                ]
            }
            constraints.append(contentsOf: applyConsidering(size: size,
                                                            base: baseContraints,
                                                            optional: plus))
        case .left:
            var baseConstraints: [NSLayoutConstraint] = []
            if #available(iOS 11.0, *) {
               baseConstraints = [
                self.leadingAnchor.constraint(equalTo:
                    referredToSafeArea ? superView.safeAreaLayoutGuide.leadingAnchor :
                        superView.leadingAnchor,
                        constant: padding.left)]
                let optionalConstraints = self.trailingAnchor.constraint(lessThanOrEqualTo:
                    referredToSafeArea ? superView.safeAreaLayoutGuide.trailingAnchor :
                    superView.trailingAnchor)
                constraints.append(contentsOf: applyConsidering(size: size,
                                                                base: baseConstraints,
                                                                optional: [optionalConstraints]))
            } else {
                baseConstraints = [
                    self.leadingAnchor.constraint(equalTo: superView.leadingAnchor,
                                                  constant: padding.left)
                ]
                let optionalConstraints = self.trailingAnchor.constraint(lessThanOrEqualTo: superView.trailingAnchor)
                constraints.append(contentsOf: applyConsidering(size: size,
                                                                base: baseConstraints,
                                                                optional: [optionalConstraints]))
            }
            constraints.append(contentsOf: baseConstraints)
        case .right:
            var baseConstraints: [NSLayoutConstraint] = []
            if #available(iOS 11.0, *) {
                baseConstraints = [
                    self.trailingAnchor.constraint(equalTo:
                        referredToSafeArea ? superView.safeAreaLayoutGuide.trailingAnchor:
                        superView.trailingAnchor,
                        constant: -padding.right)
                ]
                let optionalConstraint = self.leadingAnchor.constraint(lessThanOrEqualTo: referredToSafeArea ?
                    superView.safeAreaLayoutGuide.leadingAnchor :
                    superView.leadingAnchor,
                    constant: padding.left)
                constraints.append(contentsOf: applyConsidering(size: size,
                                                                base: baseConstraints,
                                                                optional: [optionalConstraint]))
            } else {
                baseConstraints = [
                    self.trailingAnchor.constraint(equalTo:
                        superView.trailingAnchor,
                        constant: -padding.right)
                ]
                let optionalConstraint = self.leadingAnchor.constraint(lessThanOrEqualTo:
                    superView.leadingAnchor, constant: padding.left)
                constraints.append(contentsOf:
                    applyConsidering(size: size,
                                     base: baseConstraints,
                                     optional: [optionalConstraint]))
            }
            constraints.append(contentsOf: baseConstraints)
        }
        return constraints
    }
    private func applyConsidering(size: CGSize,
                                  base: [NSLayoutConstraint],
                                  optional: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        if size == .zero {
            constraints.append(contentsOf: base)
            constraints.append(contentsOf: optional)
        } else {
            constraints.append(contentsOf: base)
            constraints.append(contentsOf: returnConstraints(for: size))
        }
        return constraints
    }
}

// MARK: Mutual position placement

public extension UIView {
    
    /// Describes the mutual position between two UIViews
    enum MutualPosition {
        /// The current view needs to be on top of the target view.
        case top
        /// The current view needs to be on the bottom of the target view.
        case bottom
        /// The current view needs to be on the left of the target view.
        case left
        /// The current view needs to be on the right of the target view.
        case right
        /// Places the view at the center of the target view
        case center
    }
    
    /// Places a view in relation of a mutual position with another view.
    /// - Parameters:
    ///   - mutualPosition: the relative position of the view.
    ///   - view: The view that we are referring to.
    ///   - padding: The amunt of distance betwen the two views.
    func placed(at mutualPosition: MutualPosition,
                horizontalAlignemnt: HorizontalAlignment = .center,
                of view: AnyArrangeable,
                padding: UIEdgeInsets = .zero) {
        let targetView = view.viewToConstraint
        self.translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        switch mutualPosition {
        case .top:
            constraints.append(self.bottomAnchor.constraint(equalTo: targetView.topAnchor,
                                                            constant: -padding.top))
        case .bottom:
            constraints.append(self.topAnchor.constraint(equalTo: targetView.bottomAnchor,
                                                         constant: padding.bottom))
        case .left:
            constraints.append(self.trailingAnchor.constraint(equalTo: targetView.leadingAnchor,
                                                              constant: -padding.left))
            constraints.append(self.centerYAnchor.constraint(equalTo: targetView.centerYAnchor))
        case .right:
            constraints.append(self.leadingAnchor.constraint(equalTo: targetView.trailingAnchor,
                                                             constant: padding.right))
            constraints.append(self.centerYAnchor.constraint(equalTo: targetView.centerYAnchor))
        case .center:
            constraints.append(self.centerXAnchor.constraint(equalTo: targetView.centerXAnchor,
                                                             constant: padding.right))
            constraints.append(self.centerYAnchor.constraint(equalTo: targetView.centerYAnchor,
                                                             constant: padding.top))
        }
        if horizontalAlignemnt == .center {
        constraints.append(self.centerXAnchor.constraint(equalTo: targetView.centerXAnchor))
        }
        constraints.activate()
    }
}

// MARK: Constraint mirroring

public extension UIView {
    
    /// Describes the possible options to choose from when copying another view's horizontal constraints.
    enum HorizontalOptions {
        /// Copy just the leading constraint.
        case left
        /// Copy just the trailing constraint.
        case right
        /// Copy all the horizontal constraints. (**default option**)
        case all
    }
    /// Describes the possible options to choose from when copying another view's vertical constraints.
    enum VerticalOptions {
        /// Copy just the bottom constraint.
        case bottom
        /// Copy just the top constraint.
        case top
        /// Copy all the vertical constraints. (**default option**)
        case all
    }
    
    /// Function that given a source model view copies all, or some of the horizontal constraints
    /// - Parameters:
    ///   - target: The view from where we copy the constraints
    ///   - options: The possible options to choose from when copying the constraints.
    ///   - padding: The amount of spacing to apply from the bvase constraints (only the horizontal amount works).
    func mirrorHLayoutGuide(from target: AnyArrangeable,
                            options: HorizontalOptions = .all,
                            padding: UIEdgeInsets = .zero) {
        let targetView = target.viewToConstraint
        var constraints: [NSLayoutConstraint]
        switch options {
        case .all:
            constraints = [
                    self.leadingAnchor.constraint(equalTo: targetView.layoutMarginsGuide.leadingAnchor,
                                                  constant: padding.left),
                    self.trailingAnchor.constraint(equalTo: targetView.layoutMarginsGuide.trailingAnchor,
                                                   constant: -padding.right)
                ]
        case .left:
            constraints = [self.leadingAnchor.constraint(equalTo: targetView.layoutMarginsGuide.leadingAnchor,
                                                         constant: padding.left)]
        case .right:
            constraints = [self.trailingAnchor.constraint(equalTo: targetView.layoutMarginsGuide.trailingAnchor,
                                                   constant: -padding.right)]
        }
        constraints.activate()
    }
    
    /// Function that given a source model view copies all, or some of the horizontal constraints
    /// - Parameters:
    ///   - target: The view from where we copy the constraints
    ///   - options: The possible options to choose from when copying the constraints.
    ///   - padding: The amount of spacing to apply from the bvase constraints (only the horizontal amount works).
    func mirrorHReadableGuide(from target: AnyArrangeable,
                            options: HorizontalOptions = .all,
                            padding: UIEdgeInsets = .zero) {
        let targetView = target.viewToConstraint
        var constraints: [NSLayoutConstraint]
        switch options {
        case .all:
            constraints = [
                    self.leadingAnchor.constraint(equalTo: targetView.readableContentGuide.leadingAnchor,
                                                  constant: padding.left),
                    self.trailingAnchor.constraint(equalTo: targetView.readableContentGuide.trailingAnchor,
                                                   constant: -padding.right)
                ]
        case .left:
            constraints = [self.leadingAnchor.constraint(equalTo: targetView.readableContentGuide.leadingAnchor,
                                                         constant: padding.left)]
        case .right:
            constraints = [self.trailingAnchor.constraint(equalTo: targetView.readableContentGuide.trailingAnchor,
                                                          constant: -padding.right)]
        }
        constraints.activate()
    }
    
    /// Function that given a source model view copies all, or some of the horizontal constraints
    /// - Parameters:
    ///   - target: The view from where we copy the constraints
    ///   - options: The possible options to choose from when copying the constraints.
    ///   - padding: The amount of spacing to apply from the bvase constraints (only the horizontal amount works).
    func mirrorHConstraints(from target: AnyArrangeable,
                       options: HorizontalOptions = .all,
                       padding: UIEdgeInsets = .zero,
                       safeArea: Bool = false) {
        let targetView = target.viewToConstraint
        var constraints: [NSLayoutConstraint]
        switch options {
        case .all:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.leadingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: padding.left),
                    self.trailingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -padding.right)
                ] : [self.leadingAnchor.constraint(equalTo: targetView.leadingAnchor,
                                                   constant: padding.left),
                     self.trailingAnchor.constraint(equalTo: targetView.trailingAnchor,
                                                    constant: -padding.right)]
            } else {
                constraints = [self.leadingAnchor.constraint(equalTo: targetView.leadingAnchor,
                                                             constant: padding.left),
                               self.trailingAnchor.constraint(equalTo: targetView.trailingAnchor,
                                                              constant: -padding.right)]
            }
            
        case .left:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.leadingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: padding.left)
                ] : [self.leadingAnchor.constraint(equalTo: targetView.leadingAnchor,
                                                   constant: padding.left)]
                
            } else {
                constraints = [self.leadingAnchor.constraint(equalTo: targetView.leadingAnchor, constant: padding.left)]
            }
        case .right:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.trailingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -padding.right)
                ] : [self.trailingAnchor.constraint(equalTo: targetView.trailingAnchor,
                                                    constant: -padding.right)]
            } else {
                constraints = [
                    self.trailingAnchor.constraint(equalTo: targetView.trailingAnchor,
                                                   constant: -padding.right)
                ]
            }
        }
        constraints.activate()
    }
    
    @available(*, deprecated, message: "use mirrorHConstraints() instead.")
    /// Function that given a source model view copies all, or some of the horizontal constraints
    /// - Parameters:
    ///   - targetView: The view from where we copy the constraints
    ///   - options: The possible options to choose from when copying the constraints.
    ///   - padding: The amount of spacing to apply from the bvase constraints (only the horizontal amount works).
    func copyAndApplyHorizontalConstraint(from targetView: UIView,
                                          options: HorizontalOptions = .all,
                                          padding: UIEdgeInsets = .zero,
                                          safeArea: Bool = false) {
        var constraints: [NSLayoutConstraint]
        switch options {
        case .all:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.leadingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: padding.left),
                    self.trailingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -padding.right)
                ] : [self.leadingAnchor.constraint(equalTo: targetView.leadingAnchor,
                                                   constant: padding.left),
                     self.trailingAnchor.constraint(equalTo: targetView.trailingAnchor,
                                                    constant: -padding.right)]
            } else {
                constraints = [self.leadingAnchor.constraint(equalTo: targetView.leadingAnchor,
                                                             constant: padding.left),
                               self.trailingAnchor.constraint(equalTo: targetView.trailingAnchor,
                                                              constant: -padding.right)]
            }
            
        case .left:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.leadingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.leadingAnchor,
                                                  constant: padding.left)
                ] : [self.leadingAnchor.constraint(equalTo: targetView.leadingAnchor,
                                                   constant: padding.left)]
                
            } else {
                constraints = [self.leadingAnchor.constraint(equalTo: targetView.leadingAnchor, constant: padding.left)]
            }
        case .right:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.trailingAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.trailingAnchor,
                                                   constant: -padding.right)
                ] : [self.trailingAnchor.constraint(equalTo: targetView.trailingAnchor,
                                                    constant: -padding.right)]
            } else {
                constraints = [
                    self.trailingAnchor.constraint(equalTo: targetView.trailingAnchor,
                                                   constant: -padding.right)
                ]
            }
        }
        constraints.activate()
    }
    
    /// Function that given a source model view copies all, or some of the horizontal constraints
    /// - Parameters:
    ///   - target: The view from where we copy the constraints
    ///   - options: The possible options to choose from when copying the constraints.
    ///   - padding: The amount of spacing to apply from the bvase constraints (only the horizontal amount works).
    func mirrorVConstraints(from target: AnyArrangeable,
                            options: VerticalOptions = .all,
                            padding: UIEdgeInsets = .zero,
                            safeArea: Bool = false) {
        let targetView = target.viewToConstraint
        var constraints: [NSLayoutConstraint]
        switch options {
        case .all:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.topAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.topAnchor,
                                              constant: padding.top),
                    self.bottomAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.bottomAnchor,
                    constant: -padding.bottom)
                    ] : [self.topAnchor.constraint(equalTo: targetView.topAnchor,
                                                   constant: padding.top),
                         self.bottomAnchor.constraint(equalTo: targetView.bottomAnchor,
                         constant: -padding.bottom)]
            } else {
                constraints = [
                    self.topAnchor.constraint(equalTo: targetView.topAnchor,
                                              constant: padding.top),
                    self.bottomAnchor.constraint(equalTo: targetView.bottomAnchor,
                                                 constant: -padding.bottom)
                ]
            }
            
        case .top:
            if #available(iOS 11.0, *) {
            constraints = safeArea ? [
                self.topAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.topAnchor,
                                          constant: padding.top)
                ] : [self.topAnchor.constraint(equalTo: targetView.topAnchor,
                                               constant: padding.top)]
            } else {
                constraints = [
                    self.topAnchor.constraint(equalTo: targetView.topAnchor,
                                              constant: padding.top)
                ]
            }
        case .bottom:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.bottomAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -padding.bottom)
                    ] : [self.bottomAnchor.constraint(equalTo: targetView.bottomAnchor,
                                                      constant: -padding.bottom)]
            } else {
                constraints = [
                    self.bottomAnchor.constraint(equalTo: targetView.bottomAnchor,
                                                 constant: -padding.bottom)
                ]
            }
        }
        constraints.activate()
    }
    
    /// Function that given a source model view copies all, or some of the vertical constraints
    /// - Parameters:
    ///   - targetView: The view from where we copy the constraints
    ///   - options: The possible options to choose from when copying the constraints.
    ///   - padding: The amount of spacing to apply from the bvase constraints (only the vertical amount works).
    func mirrorVLayoutGuide(from target: AnyArrangeable,
                            options: VerticalOptions = .all,
                            padding: UIEdgeInsets = .zero) {
        let targetView = target.viewToConstraint
        var constraints: [NSLayoutConstraint]
        switch options {
        case .all:
            constraints = [
                    self.bottomAnchor.constraint(equalTo: targetView.layoutMarginsGuide.bottomAnchor,
                                                 constant: -padding.bottom),
                    self.topAnchor.constraint(equalTo: targetView.layoutMarginsGuide.topAnchor,
                                              constant: padding.top)
                ]
        case .top:
            constraints = [self.topAnchor.constraint(equalTo: targetView.layoutMarginsGuide.topAnchor,
                                                     constant: padding.top)]
        case .bottom:
            constraints = [self.bottomAnchor.constraint(equalTo: targetView.layoutMarginsGuide.bottomAnchor,
                                                        constant: -padding.bottom)]
        }
        constraints.activate()
    }
    
    /// Function that given a source model view copies all, or some of the vertical constraints relative to the readable guide.
    /// - Parameters:
    ///   - targetView: The view from where we copy the constraints
    ///   - options: The possible options to choose from when copying the constraints.
    ///   - padding: The amount of spacing to apply from the bvase constraints (only the vertical amount works).
    func mirrorVReadableGuide(from target: AnyArrangeable,
                              options: VerticalOptions = .all,
                              padding: UIEdgeInsets = .zero) {
        let targetView = target.viewToConstraint
        var constraints: [NSLayoutConstraint]
        switch options {
        case .all:
            constraints = [
                    self.bottomAnchor.constraint(equalTo: targetView.readableContentGuide.bottomAnchor,
                                                 constant: -padding.bottom),
                    self.topAnchor.constraint(equalTo: targetView.readableContentGuide.topAnchor,
                                              constant: padding.top)
                ]
        case .top:
            constraints = [self.topAnchor.constraint(equalTo: targetView.readableContentGuide.topAnchor,
                                                     constant: padding.top)]
        case .bottom:
            constraints = [self.bottomAnchor.constraint(equalTo: targetView.readableContentGuide.bottomAnchor,
                                                        constant: -padding.bottom)]
        }
        constraints.activate()
    }
    
    @available(*, deprecated, message: "use mirrorVConstraints() instead.")
    /// Function that given a source model view copies all, or some of the horizontal constraints
    /// - Parameters:
    ///   - targetView: The view from where we copy the constraints
    ///   - options: The possible options to choose from when copying the constraints.
    ///   - padding: The amount of spacing to apply from the bvase constraints (only the horizontal amount works).
    func copyAndApplyVerticalConstraint(from targetView: UIView,
                                        options: VerticalOptions = .all,
                                        padding: UIEdgeInsets = .zero,
                                        safeArea: Bool = false) {
        var constraints: [NSLayoutConstraint]
        switch options {
        case .all:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.topAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.topAnchor,
                                              constant: padding.top),
                    self.bottomAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.bottomAnchor,
                    constant: -padding.bottom)
                    ] : [self.topAnchor.constraint(equalTo: targetView.topAnchor,
                                                   constant: padding.top),
                         self.bottomAnchor.constraint(equalTo: targetView.bottomAnchor,
                         constant: -padding.bottom)]
            } else {
                constraints = [
                    self.topAnchor.constraint(equalTo: targetView.topAnchor,
                                              constant: padding.top),
                    self.bottomAnchor.constraint(equalTo: targetView.bottomAnchor,
                                                 constant: -padding.bottom)
                ]
            }
            
        case .top:
            if #available(iOS 11.0, *) {
            constraints = safeArea ? [
                self.topAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.topAnchor,
                                          constant: padding.top)
                ] : [self.topAnchor.constraint(equalTo: targetView.topAnchor,
                                               constant: padding.top)]
            } else {
                constraints = [
                    self.topAnchor.constraint(equalTo: targetView.topAnchor,
                                              constant: padding.top)
                ]
            }
        case .bottom:
            if #available(iOS 11.0, *) {
                constraints = safeArea ? [
                    self.bottomAnchor.constraint(equalTo: targetView.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -padding.bottom)
                    ] : [self.bottomAnchor.constraint(equalTo: targetView.bottomAnchor,
                                                      constant: -padding.bottom)]
            } else {
                constraints = [
                    self.bottomAnchor.constraint(equalTo: targetView.bottomAnchor,
                                                 constant: -padding.bottom)
                ]
            }
        }
        constraints.activate()
    }
}

public extension UIView {
    /// Helper function that applies the same center coordinates from a target view
    /// - Parameters:
    ///   - view: the target view
    ///   - offset: the offset from the target center point
    func copyCenter(from view: AnyArrangeable,
                    offset: CGPoint = .zero) {
        let targetView = view.viewToConstraint
        let constraints: [NSLayoutConstraint] = [
            centerXAnchor.constraint(equalTo: targetView.centerXAnchor,
                                     constant: offset.x),
            centerYAnchor.constraint(equalTo: targetView.centerYAnchor,
                                     constant: offset.y)
        ]
        constraints.activate()
    }
}

public extension UIView {
    
    func deactivateAllConstraints() {
        NSLayoutConstraint.deactivate(self.constraints)
    }
    
    /// Utility method that helps to remove s subview inside a UIStackView.
    func deatach() {
        // Deactive all constraints at once
        NSLayoutConstraint.deactivate(constraints)
        // Remove the views from self
        removeFromSuperview()
    }
    
}

public extension Array where Element: NSLayoutConstraint {
    
    func activate() {
        NSLayoutConstraint.activate(self)
    }
    
}
#endif
