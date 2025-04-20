//
//  SampleButton.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import UIKit

public final class SampleButton: UIButton {
    private let defaultColor: UIColor
    
    public init(title: String, color: UIColor) {
        self.defaultColor = color
        super.init(frame: .zero)
        setupButton(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String) {
        setTitle(title, for: .normal)
        backgroundColor = defaultColor
        layer.cornerRadius = 8
        titleLabel?.font = .bodyL
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 48).isActive = true
    }
    
    public override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.backgroundColor = self.isHighlighted ? 
                    self.defaultColor.withAlphaComponent(0.7) : 
                    self.defaultColor
                self.transform = self.isHighlighted ? 
                    CGAffineTransform(scaleX: 0.98, y: 0.98) : 
                    .identity
            }
        }
    }
} 
