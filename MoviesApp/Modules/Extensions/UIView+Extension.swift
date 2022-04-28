//
//  UIView+Extension.swift
//  MoviesApp
//
//  Created by Ayman Fathy on 28/04/2022.
//

import Foundation

import UIKit
extension UIView {
    func xibSetup() {
        if let contentView = loadViewFromNib() {
            contentView.frame = bounds
            addSubview(contentView)
        }
    }

    fileprivate func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        return view
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return Double(self.layer.cornerRadius)
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
}
