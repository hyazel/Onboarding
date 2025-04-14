//
//  DJSliderView.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//


import UIKit
import SwiftUI

class DJSliderView: UIView {

    private let trackView = UIView()
    private let slider = UISlider()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .clear

        // Track view (capsule noire)
        trackView.backgroundColor = UIColor(white: 0.15, alpha: 1)
        trackView.layer.cornerRadius = 12
        trackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(trackView)

        // Slider transparent
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
        slider.isContinuous = true
//        slider.setMinimumTrackImage(.clear, for: .normal)
//        slider.setMaximumTrackImage(.clear, for: .normal)
        slider.setThumbImage(makeThumb(), for: .normal)
        slider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(slider)

        // Constraints
        NSLayoutConstraint.activate([
            trackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            trackView.topAnchor.constraint(equalTo: topAnchor),
            trackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            slider.leadingAnchor.constraint(equalTo: leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 32),
            slider.topAnchor.constraint(equalTo: topAnchor),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor),
            trackView.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    private func makeThumb() -> UIImage {
        let size = CGSize(width: 6, height: 24)
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            let rect = CGRect(origin: .zero, size: size)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: 3)
            UIColor.lightGray.setFill()
            path.fill()
        }
    }

    // Expose value externally
    var value: Float {
        get { slider.value }
        set { slider.value = newValue }
    }

    func onValueChanged(_ target: Any?, action: Selector) {
        slider.addTarget(target, action: action, for: .valueChanged)
    }
}

#Preview {
    DJSliderView()
}

extension UIImage {
    static func roundedRect(color: UIColor, size: CGSize, cornerRadius: CGFloat) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            let rect = CGRect(origin: .zero, size: size)
            let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            color.setFill()
            path.fill()
        }.resizableImage(withCapInsets: .zero, resizingMode: .stretch)
    }

    static func capsuleThumb(width: CGFloat, height: CGFloat, color: UIColor) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        return renderer.image { ctx in
            let rect = CGRect(origin: .zero, size: CGSize(width: width, height: height))
            let path = UIBezierPath(roundedRect: rect, cornerRadius: width / 2)
            color.setFill()
            path.fill()
        }
    }
}
