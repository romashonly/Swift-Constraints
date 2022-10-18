//
//  File.swift
//  
//
//  Created by Роман Шуркин on 19.10.2022.
//

import UIKit

public class SConstraints {
    
    private weak var view: UIView?
    
    init(view: UIView) {
        self.view = view
    }
    
    // MARK: - Instance Methods
    
    public func pin(_ sides: Side...) {
        guard let view = view else {
            return
        }

        view.translatesAutoresizingMaskIntoConstraints = false
        
        sides
            .compactMap { getConstraints(for: $0) }
            .forEach { activate($0) }
    }
    
    public func getConstraints(for side: Side) -> [NSLayoutConstraint] {
        guard
            let view = view
        else {
            return []
        }
        
        let otherView = side.view
        let otherViewSideType = side.viewSideType
        let priority = side.priotity
        
        let const = side.constant
    
        var constraints = [NSLayoutConstraint]()
        switch side.type {
        case .top, .bottom, .centerY:
            guard
                let otherView = otherView ?? view.superview,
                let mainAnchor = getYAnchor(side.type, view: view),
                let subAnchor = getYAnchor(otherViewSideType ?? side.type, view: otherView)
            else {
                break
            }
            
            constraints = [mainAnchor.constraint(equalTo: subAnchor, constant: const)]
            
        case .left, .right, .centerX:
            guard
                let otherView = otherView ?? view.superview,
                let mainAnchor = getXAnchor(side.type, view: view),
                let subAnchor = getXAnchor(otherViewSideType ?? side.type, view: otherView)
            else {
                break
            }
            
            constraints = [mainAnchor.constraint(equalTo: subAnchor, constant: const)]
            
        case .height, .width:
            guard
                let mainAnchor = getDimensionAnchor(side.type, view: view)
            else {
                break
            }
            
            if
                let otherView = otherView,
                let subAnchor = getDimensionAnchor(otherViewSideType ?? side.type, view: otherView)
            {
                constraints = [mainAnchor.constraint(equalTo: subAnchor, constant: const)]
            } else {
                constraints = [mainAnchor.constraint(equalToConstant: const)]
            }
            
        case .edges:
            constraints.append(contentsOf: getConstraints(for: side.getCopy(type: .top)))
            constraints.append(contentsOf: getConstraints(for: side.getCopy(type: .left)))
            constraints.append(contentsOf: getConstraints(for: side.getCopy(type: .right)))
            constraints.append(contentsOf: getConstraints(for: side.getCopy(type: .bottom)))
            
        case .size:
            constraints.append(contentsOf: getConstraints(for: side.getCopy(type: .height)))
            constraints.append(contentsOf: getConstraints(for: side.getCopy(type: .width)))
        }
        
        constraints.forEach {
            $0.priority = priority
        }
        
        return constraints
    }
    
    private func getXAnchor(_ type: SideType, view: UIView) -> NSLayoutAnchor<NSLayoutXAxisAnchor>? {
        switch type {
        case .left:
            return view.leftAnchor
        case .right:
            return view.rightAnchor
        case .centerX:
            return view.centerXAnchor
        default:
            return nil
        }
    }
    
    private func getYAnchor(_ type: SideType, view: UIView) -> NSLayoutAnchor<NSLayoutYAxisAnchor>? {
        switch type {
        case .top:
            return view.topAnchor
        case .bottom:
            return view.bottomAnchor
        case .centerY:
            return view.centerYAnchor
        default:
            return nil
        }
    }
    
    private func getDimensionAnchor(_ type: SideType, view: UIView) -> NSLayoutDimension? {
        switch type {
        case .height:
            return view.heightAnchor
        case .width:
            return view.widthAnchor
        default:
            return nil
        }
    }
    
    public func activate(_ constraint: NSLayoutConstraint) {
        NSLayoutConstraint.activate([constraint])
    }
    
    public func activate(_ constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints)
    }
}
