//
//  UIViewEx.swift
//  SwiftCase
//
//  Created by wtf on 2017/5/17.
//  Copyright © 2017年 Shepherd. All rights reserved.
//

import UIKit

// MARK: - extension UIView showMask
extension UIView {
    
    public func showMessage(_ message: String) {
        let label = UILabel()
        
        label.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.7)
        label.layer.cornerRadius = 5.0
        label.layer.masksToBounds = true
        label.text = message
        label.textAlignment = .center
        label.numberOfLines = 5
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        
        let frameW = self.frame.width
        let frameH = self.frame.height
        label.preferredMaxLayoutWidth = frameW - 60
        let size = label.text!.boundingRect(with: CGSize(width: frameW - 60, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: label.font], context: nil).size
        label.frame = CGRect(x: (frameW - size.width - 20) * 0.5, y: (frameH - size.height - 25) * 0.5 - 20, width: size.width + 20, height: size.height + 25)
        
        self.addSubview(label)
        
        let deadlineTime = DispatchTime.now() + DispatchTimeInterval.milliseconds(1500)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
            if label.superview == self {
                label.removeFromSuperview()
            }
        }
    }
}


