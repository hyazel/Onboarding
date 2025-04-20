//
//  WelcomeOnboardingViewController.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import UIKit
import DesignSystem
import Factory

final class WelcomeOnboardingViewController: BaseViewController {
    // MARK: - Injection
    @WeakLazyInjected(\NavigationContainer.onBoardingCoordinator) private var coordinator
    
    // MARK: - UI components
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: .logo)
        imageView.contentMode = .scaleAspectFit
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
            self.coordinator?.nextPage()
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
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let availableSpace = bottomStack.frame.minY
        logoImageView.center.y = availableSpace / 2
    }
}

// MARK: - UI Setup
private extension WelcomeOnboardingViewController {
    func setupView() {
        view.addSubview(logoImageView)
        view.addSubview(bottomStack)
        
        NSLayoutConstraint.activate([
            // Bottom stack
            bottomStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacingXL),
            bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacingXL),
            bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
            
            // Logo
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: .sizeXL),
        ])
    }
}

#Preview {
    WelcomeOnboardingViewController()
}
