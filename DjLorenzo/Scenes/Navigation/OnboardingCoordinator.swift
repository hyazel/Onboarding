//
//  OnboardingCoordinator.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import UIKit
import SwiftUI
import Factory
import DataDomain
import DesignSystem

final class OnboardingCoordinator: UINavigationController, UIPageViewControllerDelegate {
    // MARK: - Injection
    @Injected(\RepositoryContainer.userRepository) private var userRepository
    
    // MARK: - UIC components
    private let pageViewController: UIPageViewController
//    private let navigationController: UINavigationController
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = UIColor.Background.accentPrimary
        pc.pageIndicatorTintColor = UIColor.Background.inverted
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    private lazy var welcomeViewController = WelcomeOnboardingViewController()
    private lazy var logoViewController = HeroOnboardingViewController()
    private lazy var selectSkillViewController = SelectSkillViewController()
    private lazy var skill1OnboardingViewController = Skill1OnboardingViewController()
    private lazy var skill2OnboardingViewController = Skill2OnboardingViewController()
    private lazy var skill3OnboardingViewController = Skill3OnboardingViewController()
    
    private lazy var pages: [UIViewController] = [
        welcomeViewController,
        logoViewController,
        selectSkillViewController
    ]
    
    // MARK: - Init & lifecycle
    init() {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        super.init(nibName: nil, bundle: nil)
        setup()
        
        self.pageViewController.view.backgroundColor = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
        
        self.pageViewController.view.backgroundColor = .none
    }
}

// MARK: - Page Control
private extension OnboardingCoordinator {
    func setup() {
        pageViewController.dataSource = nil
        pageViewController.delegate = self
        
        setViewControllers([pageViewController], animated: false)
        if let firstVC = pages.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false)
        }
        setupPageControl()
    }
    
    func setupPageControl() {
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        
        pageViewController.view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: pageViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            pageControl.centerXAnchor.constraint(equalTo: pageViewController.view.centerXAnchor)
        ])
    }
    
    func updatePageControl() {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}

// MARK: - Navigation
extension OnboardingCoordinator {
    func nextPage() {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = pages.firstIndex(of: currentVC) else { return }
        
        if currentVC is SelectSkillViewController {
            guard let level = userRepository.getDJLevel() else { return }
            
            let nextVC: UIViewController
            switch level {
            case .beginner:
                nextVC = skill1OnboardingViewController
            case .intermediate:
                nextVC = skill2OnboardingViewController
            case .professional:
                nextVC = skill3OnboardingViewController
            }
            pages.append(nextVC)
            pageViewController.setViewControllers([nextVC], direction: .forward, animated: true) { [weak self] _ in
                self?.updatePageControl()
            }
        } else if currentIndex < pages.count - 1 {
            let nextVC = pages[currentIndex + 1]
            pageViewController.setViewControllers([nextVC], direction: .forward, animated: true) { [weak self] _ in
                self?.updatePageControl()
            }
        } else {
            finishOnboarding()
        }
    }
    
    func finishOnboarding() {
        // Replace with real app entry point
        let alert = UIAlertController(title: "Done!", message: "Onboarding finished.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
