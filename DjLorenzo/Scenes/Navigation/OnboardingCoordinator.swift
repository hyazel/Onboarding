//
//  OnboardingCoordinator.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import UIKit
import SwiftUI

class OnboardingCoordinator: NSObject, UIPageViewControllerDelegate {
    
    private let pageViewController: UIPageViewController
    private let navigationController: UINavigationController
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.pageIndicatorTintColor = .systemGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    private lazy var welcomeViewController = WelcomeOnboardingViewController(coordinator: self)
    private lazy var logoViewController = HeroOnboardingViewController(coordinator: self)
    private lazy var selectSkillViewController = SelectSkillViewController(coordinator: self)
    private lazy var skill1OnboardingViewController = Skill1OnboardingViewController(coordinator: self)
    private lazy var skill2OnboardingViewController = Skill2OnboardingViewController(coordinator: self)
    private lazy var skill3OnboardingViewController = Skill3OnboardingViewController(coordinator: self)
    
    private lazy var pages: [UIViewController] = [
        welcomeViewController,
        logoViewController,
        selectSkillViewController
    ]
    
    private let userRepository = UserRepository.shared
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        super.init()
        setup()
        
        self.pageViewController.view.backgroundColor = .none
    }
    
    func start() {
        navigationController.setViewControllers([pageViewController], animated: false)
        if let firstVC = pages.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false)
        }
        setupPageControl()
    }
    
    private func setup() {
        pageViewController.dataSource = nil
        pageViewController.delegate = self
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        
        pageViewController.view.addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: pageViewController.view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            pageControl.centerXAnchor.constraint(equalTo: pageViewController.view.centerXAnchor)
        ])
    }
    
    private func updatePageControl() {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
}

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
        navigationController.present(alert, animated: true)
    }
}

//#Preview {
//    ViewControllerView(viewController: OnBoardingLogoViewController(coordinator: <#OnboardingCoordinator#>))
//}
