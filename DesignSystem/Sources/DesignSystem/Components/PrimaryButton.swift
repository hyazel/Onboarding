import UIKit
import SwiftUI


public struct PrimaryButtonFactory {
    @MainActor
    public static func makeContinueButton(action: @escaping () -> Void) -> PrimaryButton {
        PrimaryButton(title: "Continue", action: action)
    }
}

public final class PrimaryButton: UIButton {
    
    private var action: (() -> Void)?
    
    public init(title: String, action: (() -> Void)?) {
        self.action = action
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 12
        translatesAutoresizingMaskIntoConstraints = false
        
        // Hauteur par défaut
        heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        action?()
    }
    
    public override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                self.alpha = self.isHighlighted ? 0.8 : 1.0
            }
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            self.layer.opacity = isEnabled ? 1 : 0.5
        }
    }
    
    func setFullWidth(in view: UIView, withMargins margins: CGFloat = 20) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: margins),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margins)
        ])
    }
}

#Preview {
    PrimaryButton(title: "Continue") {
        
    }
}
