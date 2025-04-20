//
//  Skill1OnboardingViewController.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 12/04/2025.
//

import UIKit
import SwiftUI
import DesignSystem
import Player
import Factory

final class Skill1OnboardingViewController: BaseViewController {
    // MARK: - Injection
    @WeakLazyInjected(\NavigationContainer.onBoardingCoordinator) private var coordinator
    @Injected(\PlayerContainer.player) private var player
    
    // MARK: - Local variables
    private var hasReachedMaxVolume = false
    
    // MARK: - UI components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Control the volume"
        label.textColor = .Text.primary
        label.textAlignment = .center
        label.font = .headingL
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Slide to adjust the volume"
        label.textColor = .Text.secondary
        label.textAlignment = .center
        label.font = .bodyL
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let vinylImageView: UIImageView = {
        let imageView = UIImageView(image: .vinyl)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var volumeSlider: VolumeSlider = {
        let slider = VolumeSlider()
        slider.addTarget(self, action: #selector(volumeChanged), for: .valueChanged)
        return slider
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
            vinylImageView,
            volumeSlider
        ])
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.setCustomSpacing(8, after: titleLabel)
        
        return stackView
    }()
    
    private var vinylRotationAnimation: CABasicAnimation = {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 3
        rotation.isCumulative = true
        rotation.repeatCount = Float.infinity
        rotation.timingFunction = CAMediaTimingFunction(name: .linear)
        return rotation
    }()
    
    // MARK: - Init and view lifecycle
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        loadAudio()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.stop()
        stopVinylAnimation()
    }
}

// MARK: - UI setup
private extension Skill1OnboardingViewController {
    func setupLayout() {
        view.addSubview(scrollView)
        view.addSubview(continueButton)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            // ScrollView constraints
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: 0),
            
            // StackView constraints
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: .spacingXL),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -.spacingXL),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -2 * CGFloat.spacingXL),
            
            // Continue button constraints
            continueButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: .spacingXL),
            continueButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -.spacingXL),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -2 * CGFloat.spacingXL),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Vinyl size
            vinylImageView.heightAnchor.constraint(equalToConstant: 256),
            vinylImageView.widthAnchor.constraint(equalToConstant: 256),
            
            // Slider width and height
            volumeSlider.widthAnchor.constraint(equalTo: vinylImageView.widthAnchor),
            volumeSlider.heightAnchor.constraint(equalToConstant: 48),
            volumeSlider.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -.spacingL),
            
            // Labels width
            titleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        let centerY = stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        centerY.priority = .defaultLow
        centerY.isActive = true
        
        let height = stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = .defaultLow - 1
        height.isActive = true
        
        // Content padding
        stackView.topAnchor.constraint(greaterThanOrEqualTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
    }
}

// MARK: - Player actions
private extension Skill1OnboardingViewController {
    func loadAudio() {
        do {
            try player.loadTrack(named: "track")
            player.play()
            player.volume = volumeSlider.value
        } catch {
            print("Failed to load audio:", error)
        }
    }
    
    @objc func volumeChanged(_ sender: UISlider) {
        let roundedValue = round(sender.value * 10) / 10
        sender.value = roundedValue
        player.volume = roundedValue
        
        if roundedValue >= 1.0 && !hasReachedMaxVolume {
            hasReachedMaxVolume = true
            animateTextChange()
        }
        continueButton.isEnabled = hasReachedMaxVolume
    }
}

// MARK: - Animations
private extension Skill1OnboardingViewController {
    func startVinylAnimation() {
        let duration = volumeSlider.value == 0 ? 0 : max(8 - (volumeSlider.value * 6), 2)
        vinylRotationAnimation.duration = CFTimeInterval(duration)
        vinylImageView.layer.add(vinylRotationAnimation, forKey: "rotationAnimation")
    }
    
    func stopVinylAnimation() {
        vinylImageView.layer.removeAnimation(forKey: "rotationAnimation")
    }
    
    func animateTextChange() {
        UIView.animate(withDuration: 0.3, animations: {
            self.titleLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.titleLabel.alpha = 0
            self.subtitleLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            self.subtitleLabel.alpha = 0
        }) { _ in
            self.titleLabel.text = "Yeah !"
            self.subtitleLabel.text = "You've made your first DJ move"
            
            UIView.animate(withDuration: 0.3) {
                self.titleLabel.transform = .identity
                self.titleLabel.alpha = 1
                self.subtitleLabel.transform = .identity
                self.subtitleLabel.alpha = 1
            }
        }
    }
}

#Preview {
    Skill1OnboardingViewController()
} 
