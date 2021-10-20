//
//  UIViewExtensions.swift
//  MyIDSignMobileAttempt
//
//  Created by Francesco Bianco on 05/12/2019.
//  Copyright © 2019 Francesco Bianco. All rights reserved.
//

import Foundation
#if canImport(UIKit)
import UIKit
public extension UIView {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10,
                                                       y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10,
                                                     y: self.center.y))
        self.layer.add(animation,
                       forKey: "position")
    }
    
    func layerScaleAnimation(duration: CFTimeInterval,
                             fromValue: CGFloat = 1.0,
                             toValue: CGFloat) {
        let timing = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        let scaleAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.scale")

        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timing)
        scaleAnimation.duration = duration
        scaleAnimation.fromValue = fromValue
        scaleAnimation.toValue = toValue
        scaleAnimation.autoreverses = true
        self.layer.add(scaleAnimation, forKey: "scale")
        CATransaction.commit()
    }
}
#endif
