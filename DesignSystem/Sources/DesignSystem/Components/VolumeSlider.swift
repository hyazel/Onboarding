//
//  VolumeSlider.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import UIKit
import SwiftUI

public final class VolumeSlider: UISlider {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSlider()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSlider()
    }
    
    private func setupSlider() {
        minimumValue = 0
        maximumValue = 1
        value = 0
        
        // Custom appearance
        minimumTrackTintColor = .clear
        maximumTrackTintColor = .clear
        
        // Background track
        let trackHeight: CGFloat = 48
        let trackWidth: CGFloat = UIScreen.main.bounds.width
        let trackSize = CGSize(width: trackWidth, height: trackHeight)
        let trackRect = CGRect(origin: .zero, size: trackSize)
        
        UIGraphicsBeginImageContextWithOptions(trackSize, false, 0.0)
        
        // Draw track background
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.Background.primary.cgColor)
        let trackPath = UIBezierPath(roundedRect: trackRect, cornerRadius: .radiusS)
        trackPath.fill()
        
        let trackImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        setMinimumTrackImage(trackImage, for: .normal)
        setMaximumTrackImage(trackImage, for: .normal)
        
        // Custom thumb
        let thumbWidth: CGFloat = 24
        let thumbHeight: CGFloat = trackHeight + 8
        let thumbSize = CGSize(width: thumbWidth, height: thumbHeight)
        let thumbRect = CGRect(origin: .zero, size: thumbSize)
        
        UIGraphicsBeginImageContextWithOptions(thumbSize, false, 0.0)
        
        // Draw thumb background
        UIColor.lightGray.setFill()
        UIBezierPath(roundedRect: thumbRect, cornerRadius: thumbWidth/2).fill()
        
        // Draw white capsule
        let capsuleWidth: CGFloat = 4
        let capsuleHeight: CGFloat = thumbHeight - 16
        let capsuleRect = CGRect(
            x: (thumbWidth - capsuleWidth) / 2,
            y: (thumbHeight - capsuleHeight) / 2,
            width: capsuleWidth,
            height: capsuleHeight
        )
        UIColor.white.setFill()
        UIBezierPath(roundedRect: capsuleRect, cornerRadius: capsuleWidth/2).fill()
        
        let thumbImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        setThumbImage(thumbImage, for: .normal)
        setThumbImage(thumbImage, for: .highlighted)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
} 

#Preview {
    VolumeSlider()
}
