//
//  ScalingFont.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 14/04/2025.
//
import UIKit

public extension UIFont {

    static var headingL: UIFont { designSystem(.headingL) }
    static var headingM: UIFont { designSystem(.headingM) }
    static var headingS: UIFont { designSystem(.headingS) }

    static var bodyL: UIFont { designSystem(.bodyL) }
    static var bodyM: UIFont { designSystem(.bodyM) }
    static var bodyS: UIFont { designSystem(.bodyS) }
    
    static func designSystem(_ fontTextStyle: FontTextStyle, shouldScaleWithDynamicType: Bool = true) -> UIFont {
        designSystemFont(fontTextStyle, shouldScaleWithDynamicType: shouldScaleWithDynamicType)
    }
}

private extension UIFont {
    static func designSystemFont(_ fontTextStyle: FontTextStyle, shouldScaleWithDynamicType: Bool = true) -> UIFont {
        let fontSize = fontTextStyle.size(shouldScaleWithDynamicType: shouldScaleWithDynamicType)
        return designSystemFont(size: fontSize, weight: fontTextStyle.weight)
    }
    
    static func designSystemFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        .systemFont(ofSize: size, weight: weight)
    }
}
