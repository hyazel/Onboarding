//
//  SelectSkillViewController.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 12/04/2025.
//

import UIKit
import SwiftUI
import DesignSystem
import Factory
import DataDomain

final class SelectSkillViewController: BaseViewController {
    // MARK: - Injection
    @Injected(\RepositoryContainer.userRepository) private var userRepository
    @WeakLazyInjected(\NavigationContainer.onBoardingCoordinator) private var coordinator
    
    // MARK: - UI components
    private let radioGroup: RadioGroup
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: .djhead)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What's your DJ level?"
        label.textColor = .Text.primary
        label.textAlignment = .center
        label.font = .headingL
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Select your experience level"
        label.textColor = .Text.secondary
        label.textAlignment = .center
        label.font = .bodyL
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var continueButton: UIButton = {
        let button = PrimaryButtonFactory.makeContinueButton {
            self.coordinator?.nextPage()
        }
        button.isEnabled = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let topSpacer = UIView()
        let bottomSpacer = UIView()
        
        let stackView = UIStackView(arrangedSubviews: [
            topSpacer,
            logoImageView,
            titleLabel,
            subtitleLabel,
            radioGroup,
            bottomSpacer
        ])
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Make spacers equal height to center content
        topSpacer.heightAnchor.constraint(equalTo: bottomSpacer.heightAnchor).isActive = true
        
        return stackView
    }()
    
    // MARK: - Init
    init() {
        self.radioGroup = RadioGroup(options: DJLevel.allCases.map { $0.rawValue })
        super.init(nibName: nil, bundle: nil)
        self.radioGroup.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLayout()
    }
}

// MARK: - UI Setup
private extension SelectSkillViewController {
    func setupLayout() {
        view.addSubview(scrollView)
        view.addSubview(continueButton)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -32),
            
            // StackView constraints
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: .spacingXL),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -.spacingXL),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor,
                                             constant: -2 * CGFloat.spacingXL),
            
            // Continue button constraints
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacingXL),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacingXL),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2 * CGFloat.spacingXL),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Radio group width
            radioGroup.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            radioGroup.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            
            // Labels width
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
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
// MARK: - RadioGroupDelegate
extension SelectSkillViewController: RadioGroupDelegate {
    func radioGroup(_ radioGroup: RadioGroup, didSelectOption title: String) {
        if let level = DJLevel(rawValue: title) {
            userRepository.saveDJLevel(level)
            continueButton.isEnabled = true
        }
    }
}

#Preview {
    SelectSkillViewController()
}
