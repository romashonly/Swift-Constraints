//
//  File.swift
//  
//
//  Created by Роман Шуркин on 19.10.2022.
//

import UIKit

public struct Side {
    public static func top(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .top)
    }
    public static func bottom(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .bottom)
    }
    public static func left(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .left)
    }
    public static func right(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .right)
    }
    public static func centerX(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .centerX)
    }
    public static func centerY(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .centerY)
    }
    public static func height(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .height)
    }
    public static func width(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .width)
    }
    public static func edges(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .edges)
    }
    public static func size(_ constant: CGFloat = 0) -> Self {
        Self(constant: constant, type: .size)
    }
    
    
    private(set) var constant: CGFloat = 0
    let type: SideType
    
    private(set) var view: UIView?
    private(set) var viewSideType: SideType?
    private(set) var priotity: UILayoutPriority = .required
    
    func getCopy(type: SideType) -> Self {
        Self(
            constant: constant,
            type: type,
            view: view,
            viewSideType: viewSideType,
            priotity: priotity
        )
    }
    
    public func to(_ view: UIView) -> Self {
        var local = self
        local.view = view
        return local
    }
    
    public func to(_ view: UIView, _ sideType: SideType) -> Self {
        var local = self
        local.view = view
        local.viewSideType = viewSideType
        return local
    }
    
    public func withPriority(_ priotity: UILayoutPriority) -> Self {
        var local = self
        local.priotity = priotity
        return local
    }
}
