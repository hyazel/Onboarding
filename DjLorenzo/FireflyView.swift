//
//  FireflyView.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//
import UIKit
import SwiftUI

import UIKit

class HaloView: UIView {

    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    private let colorLayer = UIView()

    init(color: UIColor = .systemBlue, radius: CGFloat = 80) {
        let size = radius * 2
        super.init(frame: CGRect(origin: .zero, size: CGSize(width: size, height: size)))
        setup(color: color, radius: radius)
        animate()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup(color: .systemBlue, radius: 80)
        animate()
    }

    private func setup(color: UIColor, radius: CGFloat) {
        backgroundColor = .clear

        // Couche de couleur floutée
        colorLayer.frame = bounds
        colorLayer.backgroundColor = color.withAlphaComponent(0.25)
        colorLayer.layer.cornerRadius = bounds.width / 2
        colorLayer.clipsToBounds = true
        addSubview(colorLayer)

        // Effet de flou par-dessus
        blurView.frame = bounds
        blurView.layer.cornerRadius = bounds.width / 2
        blurView.clipsToBounds = true
        addSubview(blurView)
    }

    private func animate() {
        // Opacité : pulsation douce
        let fade = CABasicAnimation(keyPath: "opacity")
        fade.fromValue = 0.5
        fade.toValue = 1.0
        fade.duration = 2.5
        fade.autoreverses = true
        fade.repeatCount = .infinity
        layer.add(fade, forKey: "halo-pulse")

        // Léger mouvement flottant
        let moveX = CGFloat.random(in: -6...6)
        let moveY = CGFloat.random(in: -6...6)
        UIView.animate(withDuration: 4.0,
                       delay: 0,
                       options: [.autoreverse, .repeat, .curveEaseInOut],
                       animations: {
            self.transform = CGAffineTransform(translationX: moveX, y: moveY)
        }, completion: nil)
    }
}

#Preview {
    FireflyPreviewView()
            .frame(width: 300, height: 300)
}

struct FireflyPreviewView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let container = UIView()
        container.backgroundColor = .black

        let firefly = HaloView()
        firefly.center = CGPoint(x: 150, y: 150)
        container.addSubview(firefly)

        return container
    }

    func updateUIView(_ uiView: UIView, context: Context) { }
}
