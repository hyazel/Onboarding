//
//  SemanticValues.swift
//  DesignSystem
//
//  Created by Laurent Droguet on 14/04/2025.
//

import Foundation

extension CGFloat {
    
    enum Spacing {
        static let spacing2XS: CGFloat = 2.0
        static let spacingXS: CGFloat = 4.0
        static let spacingS: CGFloat = 8.0
        static let spacingM: CGFloat = 16.0
        static let spacingL: CGFloat = 24.0
        static let spacingXL: CGFloat = 32.0
        static let spacing2XL: CGFloat = 40.0
        static let spacing3XL: CGFloat = 64.0
    }

    enum CornerRadius {
        static let radius2XS: CGFloat = 2.0
        static let radiusXS: CGFloat = 4.0
        static let radiusS: CGFloat = 8.0
        static let radiusL: CGFloat = 12.0
    }
    
    enum Size {
        static let size2XS: CGFloat = 8.0
        static let sizeXS: CGFloat = 12.0
        static let sizeS: CGFloat = 24.0
        static let sizeL: CGFloat = 40.0
        static let sizeXL: CGFloat = 64.0
    }
}

public extension CGFloat {

    ///  spacing of 2 pts
    static var spacing2XS: CGFloat { .Spacing.spacing2XS }
    
    /// spacing of 4 pts
    static var spacingXS: CGFloat { .Spacing.spacingXS }

    /// spacing of 8 pts
    static var spacingS: CGFloat { .Spacing.spacingS }

    /// spacing of 16 pts
    static var spacingM: CGFloat { .Spacing.spacingM }

    /// spacing of 24 pts
    static var spacingL: CGFloat { .Spacing.spacingL }

    /// spacing of 32 pts
    static var spacingXL: CGFloat { .Spacing.spacingXL }

    /// spacing of 40 pts
    static var spacing2XL: CGFloat { .Spacing.spacing2XL }
    
    /// spacing of 64 pts
    static var spacing3XL: CGFloat { .Spacing.spacing3XL }

}

public extension CGFloat {

    /// corner radius of 2 pts
    static var radius2XS: CGFloat { .CornerRadius.radius2XS }

    /// corner radius of 4 pts
    static var radiusXS: CGFloat { .CornerRadius.radiusXS }

    /// corner radius of 8 pts
    static var radiusS: CGFloat { .CornerRadius.radiusS }

    /// corner radius of 12 pts
    static var radiusL: CGFloat { .CornerRadius.radiusL }

}

public extension CGFloat {

    /// size of 8 pts
    static var size2XS: CGFloat { .Size.size2XS }

    /// size of 16 pts
    static var sizeXS: CGFloat { .Size.sizeXS }

    /// size of 24 pts
    static var sizeS: CGFloat { .Size.sizeS }
    
    /// size of 40 pts
    static var sizeL: CGFloat { .Size.sizeL }
    
    /// size of 64 pts
    static var sizeXL: CGFloat { .Size.sizeXL }

}
