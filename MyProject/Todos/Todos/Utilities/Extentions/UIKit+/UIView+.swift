//
//  UIView+.swift
//  Todos
//
//  Created by admin on 3/4/25.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    
    func anchor(top:NSLayoutYAxisAnchor? = nil,
                left:NSLayoutXAxisAnchor? = nil,
                bottom:NSLayoutYAxisAnchor? = nil,
                right:NSLayoutXAxisAnchor? = nil,
                paddingTop:CGFloat = 0,
                paddingLeft:CGFloat = 0,
                paddingBottom:CGFloat = 0,
                paddingRight:CGFloat = 0,
                width:CGFloat? = nil,
                height:CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView, offsetX: CGFloat = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offsetX).isActive = true
        }
        
        func centerY(inView view: UIView, offsetY: CGFloat = 0) {
            translatesAutoresizingMaskIntoConstraints = false
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offsetY).isActive = true
        }
        
        func center(inView view: UIView, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {
            centerX(inView: view, offsetX: offsetX)
            centerY(inView: view, offsetY: offsetY)
        }
}
