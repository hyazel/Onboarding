//
//  ViewController.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 12/04/2025.
//

import UIKit
import SwiftUI
import DesignSystem
import Factory

final class HeroOnboardingViewController: BaseViewController {
    // MARK: - Injection
    @WeakLazyInjected(\NavigationContainer.onBoardingCoordinator) private var coordinator
    
    // MARK: - UI
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
            self.coordinator?.nextPage()
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
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

// MARK: - SetupUI
private extension HeroOnboardingViewController {
    func setupLayout() {
        view.addSubview(scrollView)
        view.addSubview(continueButton)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor,
                                               constant: -56), // so stackView doesnt overlapp continuButton
            
            // StackView constraints
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: .spacingXL),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -.spacingXL),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor,
                                             constant: -2 * CGFloat.spacingXL),
            
            // Continue button constraints
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacingXL),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacingXL),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2 * CGFloat.spacingXL),
            
            // Fixed heights for images
            logoImageView.heightAnchor.constraint(equalToConstant: .sizeXL),
            devicesImageView.heightAnchor.constraint(equalToConstant: 200),
            awardImageView.heightAnchor.constraint(equalToConstant: .sizeXL),
            
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
    HeroOnboardingViewController()
}
