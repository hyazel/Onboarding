//
//  RadioButton.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import UIKit

public class RadioButton: UIControl {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .bodyL
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let radioCircle: UIView = {
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.cornerRadius = .radiusL
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    public override var isSelected: Bool {
        didSet {
            updateSelection()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor(white: 1, alpha: 0.25)
        layer.cornerRadius = .radiusL
        layer.borderWidth = 0
        layer.masksToBounds = true
        
        addSubview(radioCircle)
        radioCircle.addSubview(checkmarkImageView)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // Radio circle
            radioCircle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .spacingM),
            radioCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            radioCircle.widthAnchor.constraint(equalToConstant: .sizeS),
            radioCircle.heightAnchor.constraint(equalToConstant: .sizeS),
            
            // Checkmark
            checkmarkImageView.centerXAnchor.constraint(equalTo: radioCircle.centerXAnchor),
            checkmarkImageView.centerYAnchor.constraint(equalTo: radioCircle.centerYAnchor),
            checkmarkImageView.widthAnchor.constraint(equalToConstant: .sizeXS),
            checkmarkImageView.heightAnchor.constraint(equalToConstant: .sizeXS),
            
            // Title
            titleLabel.leadingAnchor.constraint(equalTo: radioCircle.trailingAnchor, constant: .spacingM),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.spacingM),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Button height
            heightAnchor.constraint(equalToConstant: 56)
        ])
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    private func updateSelection() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.radioCircle.backgroundColor = self.isSelected ? .systemBlue : .clear
            self.radioCircle.layer.borderColor = (self.isSelected ? UIColor.systemBlue : UIColor.systemGray).cgColor
            self.checkmarkImageView.isHidden = !self.isSelected
            
            self.layer.borderWidth = self.isSelected ? 1 : 0
            self.layer.borderColor = UIColor.systemBlue.cgColor
            
            // Animation de scale pour le bouton sélectionné
            self.transform = self.isSelected ? CGAffineTransform(scaleX: 1.02, y: 1.02) : .identity
        }
    }
    
    @objc private func handleTap() {
        isSelected.toggle()
        sendActions(for: .valueChanged)
    }
} 
