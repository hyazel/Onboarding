import UIKit
import SwiftUI
import DesignSystem

class Skill3OnboardingViewController: UIViewController {
    
    private let coordinator: OnboardingCoordinator
    private let player = Player()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Crowd detected"
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
            self.coordinator.nextPage()
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
        
        let blurUIView = makeBlurUIView()
            blurUIView.translatesAutoresizingMaskIntoConstraints = false
            blurUIView.backgroundColor = .clear // Important pour transparence

            view.addSubview(blurUIView)

            
        
        
        setupLayout()
        setupLights()
        playIntroSample()
        
        NSLayoutConstraint.activate([
            blurUIView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurUIView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurUIView.centerXAnchor.constraint(equalTo: djDeckImageView.centerXAnchor),
            blurUIView.centerYAnchor.constraint(equalTo: djDeckImageView.centerYAnchor, constant: -50)
        ])
        
        blurUIView.alpha = 0
        
        UIView.animate(withDuration: 15.0) {
            blurUIView.alpha = 0.5
        }
        
        // Réactiver le bouton après 15 secondes
        DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) { [weak self] in
            self?.continueButton.isEnabled = true
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    private func setupLayout() {
        view.addSubview(scrollView)
        view.addSubview(continueButton)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -32),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -56),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            
            djDeckImageView.heightAnchor.constraint(equalToConstant: 300),
            djDeckImageView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
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
    
    private func playIntroSample() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SamplePlayer.play(.stageIntro)
        }
    }
    
    private func setupLights() {
        // Implementation of setupLights method
    }
    
    private func animateLights() {
        // Implementation of animateLights method
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        player.stop()
    }
}

#Preview {
    Skill3OnboardingViewController(coordinator: OnboardingCoordinator(navigationController: .init()))
}


