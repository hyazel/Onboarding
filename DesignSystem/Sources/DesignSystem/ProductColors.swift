//
//  ProductColors.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 14/04/2025.
//

import SwiftUI

public extension UIColor {
    enum Text {
        public static let primary = UIColor(resource: .neutral00)
        public static let secondary = UIColor(resource: .neutral100)
    }
    
    enum Background {
        public static let inverted = UIColor(resource: .neutral00)
        @MainActor public static let gradientLayer: CAGradientLayer = {
            let layer = CAGradientLayer()
            layer.colors = [
                UIColor.black.cgColor,
                UIColor(red: 0.15, green: 0.15, blue: 0.25, alpha: 1.0).cgColor
            ]
            layer.locations = [0.0, 1.0]
            layer.startPoint = CGPoint(x: 0.5, y: 0.0)
            layer.endPoint = CGPoint(x: 0.5, y: 1.0)
            return layer
        }()
    }
//    
//    enum Border {
//        public static let primary = Color(.neutral170)
//        public static let secondary = Color(.green140)
//        public static let tertiary = Color(.neutral90)
//        public static let accentPrimary = Color(.green100)
//        public static let accentSecondary = Color(.green140)
//    }
//    
//    enum Icon {
//        public static let primary = Color(.white)
//        public static let secondary = Color(.neutral100)
//        public static let tertiary = Color(.neutral80)
//        public static let inverted = Color(.neutral200)
//        public static let disabled = Color(.neutral60)
//        public static let accentPrimary = Color(.green100)
//    }
}

//extension Bundle {
//    public static var designBundle: Bundle = .module
//}
