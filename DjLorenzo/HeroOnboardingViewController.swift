//
//  ViewController.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 12/04/2025.
//

import UIKit
import SwiftUI
import DesignSystem

class HeroOnboardingViewController: UIViewController {
    
    private let coordinator: OnboardingCoordinator
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: .logo)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let devicesImageView: UIImageView = {
        let imageView = UIImageView(image: .devices)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mix Your\nFavorite Music"
        label.textColor = .Text.primary
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .headingL
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let awardImageView: UIImageView = {
        let imageView = UIImageView(image: .designAward)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var continueButton: UIButton = {
        PrimaryButtonFactory.makeContinueButton {
            self.coordinator.nextPage()
        }
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            logoImageView,
            devicesImageView,
            titleLabel,
            awardImageView
        ])
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        view.backgroundColor = .black
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        view.addSubview(continueButton)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -32),
            
            // StackView constraints
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40),
            
            // Continue button constraints
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Fixed heights for images
            logoImageView.heightAnchor.constraint(equalToConstant: 64),
            devicesImageView.heightAnchor.constraint(equalToConstant: 200),
            awardImageView.heightAnchor.constraint(equalToConstant: 40),
            
            // Title label width
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        // Center vertically with scroll if content is smaller
        let centerY = stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        centerY.priority = .defaultLow
        centerY.isActive = true
        
        // Make sure content fills scroll view height if smaller
        let height = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = .defaultLow - 1
        height.isActive = true
        
        // Content padding
        stackView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
    }
}

#Preview {
    HeroOnboardingViewController(coordinator: OnboardingCoordinator(navigationController: UINavigationController()))
}
