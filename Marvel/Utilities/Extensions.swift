//
//  Extensions.swift
//  Marvel
//
//  Created by nithindev.narayanan on 10/12/20.
//

import  UIKit

extension UIView {
    
    func addSubViewsForAutoLayout(_ subViews: [UIView]) {
        
        for subview in subViews {

            subview.translatesAutoresizingMaskIntoConstraints = false
            addSubview(subview)
        }
    }
    
    func addSubviewForAutolayout(_ subview: UIView) {

        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
}
