//
//  AnyArrangeable.swift
//  
//
//  Created by Francesco Bianco on 28/09/2020.
//

import Foundation

#if canImport(UIKit)
import UIKit

public protocol AnyArrangeable: AnyObject {
    
    var viewToConstraint: UIView { get }
}

extension UIView: AnyArrangeable {
    
    public var viewToConstraint: UIView {
        return self
    }
}

extension UIViewController: AnyArrangeable {
    
    public var viewToConstraint: UIView {
        return self.view
    }
}

#endif
