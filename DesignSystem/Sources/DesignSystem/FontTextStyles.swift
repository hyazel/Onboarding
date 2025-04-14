//
//  FontStyles.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 27/03/2025.
//

import SwiftUI

public enum FontTextStyle {
    case headingXL
    case headingL
    case headingM
    case headingS
    
    case bodyL
    case bodyM
    case bodyS
}

extension FontTextStyle {
    var size: CGFloat {
        switch self {
        case .headingXL: return 48
        case .headingL: return 34
        case .headingM: return 22
        case .headingS: return 16
            
        case .bodyL: return 17 // I would have taken 16
        case .bodyM: return 14
        case .bodyS: return 14
        }
    }
    
    var weight: UIFont.Weight {
        switch self {
        case .headingXL: return .bold
        case .headingL: return .bold
        case .headingM: return .bold
        case .headingS: return .bold
            
        case .bodyL: return .semibold
        case .bodyM: return .regular
        case .bodyS: return .regular
        }
    }
}

extension FontTextStyle {
    func size(shouldScaleWithDynamicType: Bool) -> CGFloat {
        shouldScaleWithDynamicType
        ? round(UIFontMetrics.default.scaledValue(for: size))
        : size
    }
    
    func size(for sizeCategory: ContentSizeCategory) -> CGFloat {
        let uiContentSizeCategory = UIContentSizeCategory(sizeCategory)
        let traitCollection = UITraitCollection(preferredContentSizeCategory: uiContentSizeCategory)
        return round(UIFontMetrics.default.scaledValue(for: size, compatibleWith: traitCollection))
    }
}
