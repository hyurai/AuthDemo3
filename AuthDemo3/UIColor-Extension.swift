//
//  UIColor-Extension.swift
//  AuthDemo3
//
//  Created by 永井佑磨 on 2021/02/13.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat ) -> UIColor{
         return self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
