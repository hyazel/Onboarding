//
//  WelcomeOnboardingViewController.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import UIKit
import DesignSystem

final class WelcomeOnboardingViewController: UIViewController {
    
    private let coordinator: OnboardingCoordinator
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: .logo)
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .vertical)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to djay!"
        label.font = .bodyM
        label.textColor = .Text.primary
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var continueButton: PrimaryButton = {
        PrimaryButtonFactory.makeContinueButton {
            self.coordinator.nextPage()
        }
    }()
    
    private lazy var bottomStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [titleLabel, continueButton])
        stack.axis = .vertical
        stack.spacing = .spacingL
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let gradientLayer: CAGradientLayer = {
        UIColor.Background.gradientLayer
    }()
    
    init(coordinator: OnboardingCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = view.bounds
        let availableSpace = bottomStack.frame.minY
        logoImageView.center.y = availableSpace / 2
    }
    
    private func setupGradient() {
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func setupView() {
        view.addSubview(logoImageView)
        view.addSubview(bottomStack)
        
        NSLayoutConstraint.activate([
            // Bottom stack
            bottomStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: .spacingXL),
            bottomStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -.spacingXL),
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
            
            // Logo
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}

#Preview {
    WelcomeOnboardingViewController(coordinator: OnboardingCoordinator(navigationController: UINavigationController()))
}
