//
//  Skill3OnboardingViewController.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 12/04/2025.
//

import UIKit
import SwiftUI
import DesignSystem
import Player
import Factory

class Skill3OnboardingViewController: BaseViewController {
    
    // MARK: - Injection
    @WeakLazyInjected(\NavigationContainer.onBoardingCoordinator) private var coordinator
    @Injected(\PlayerContainer.player) private var player
    
    // MARK: - UI components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Crowd detected 🎧"
        label.textColor = .Text.primary
        label.textAlignment = .center
        label.font = .headingL
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Deck loading ..."
        label.textColor = .Text.secondary
        label.textAlignment = .center
        label.font = .bodyL
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let djDeckImageView: UIImageView = {
        let imageView = UIImageView(image: .djDeck)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var continueButton: UIButton = {
        let button = PrimaryButtonFactory.makeContinueButton {
            self.coordinator?.nextPage()
        }
        button.isEnabled = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            djDeckImageView
        ])
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.setCustomSpacing(8, after: titleLabel)
        return stackView
    }()
    
    private lazy var blurLightView: UIView = {
        let view = BlurView.makeUIView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: - Init & lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        playIntroSample()
        animateLights()
        continueButtonAnimation()
        animateTextAfterDelay()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.stop()
    }
}

// MARK: - UI setup
private extension Skill3OnboardingViewController {
    func setupLayout() {
        view.addSubview(blurLightView)
        view.addSubview(scrollView)
        view.addSubview(continueButton)
        scrollView.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -32),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: 0),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat.spacingXL),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -CGFloat.spacingXL),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2 * CGFloat.spacingXL),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            
            djDeckImageView.heightAnchor.constraint(equalToConstant: 300),
            djDeckImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            blurLightView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurLightView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurLightView.centerXAnchor.constraint(equalTo: djDeckImageView.centerXAnchor),
            blurLightView.centerYAnchor.constraint(equalTo: djDeckImageView.centerYAnchor, constant: -50)
        ])
        
        let centerY = stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        centerY.priority = .defaultLow
        centerY.isActive = true
        
        let height = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = .defaultLow - 1
        height.isActive = true
        
        stackView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        
    }
}

// MARK: - Animation
private extension Skill3OnboardingViewController {
    func animateLights() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 17.0) {
                self.blurLightView.alpha = 0.5
            }
        }
    }
    
    func continueButtonAnimation() {
        // Réactiver le bouton après 15 secondes
        DispatchQueue.main.asyncAfter(deadline: .now() + 17.0) { [weak self] in
            self?.continueButton.isEnabled = true
        }
    }
    
    func animateTextAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 17) { [weak self] in
            self?.animateTextChange()
        }
    }
    
    func animateTextChange() {
        UIView.animate(withDuration: 0.3, animations: {
            self.titleLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.titleLabel.alpha = 0
            self.subtitleLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.subtitleLabel.alpha = 0
        }) { _ in
            self.titleLabel.text = "You’re live."
            self.subtitleLabel.text = "Showtime."
            
            UIView.animate(withDuration: 0.3) {
                self.titleLabel.transform = .identity
                self.titleLabel.alpha = 1
                self.subtitleLabel.transform = .identity
                self.subtitleLabel.alpha = 1
            }
        }
    }
}

// MARK: - Player
private extension Skill3OnboardingViewController {
    func playIntroSample() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SamplePlayer.play(.stageIntro)
        }
    }
}

#Preview {
    Skill3OnboardingViewController()
}
