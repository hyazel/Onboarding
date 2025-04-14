//
//  IntroPageViewController.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 12/04/2025.
//

import UIKit

//class IntroPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//
//    private let pages: [UIViewController] = [
//        OnBoardingLogoViewController(),
//        SelectSkillViewController()
//    ]
//
//    private let pageControl = UIPageControl()
//
//    init() {
//        super.init(
//            transitionStyle: .scroll,  // ← C’est ici que tu changes le style
//            navigationOrientation: .horizontal,
//            options: nil
//        )
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        dataSource = self
//        delegate = self
//        setViewControllers([pages[0]],direction: .forward, animated: true, completion: nil)
//
//        pageControl.numberOfPages = pages.count
//        pageControl.currentPage = 0
//        
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(pageControl)
//
//        NSLayoutConstraint.activate([
//            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
//            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        guard let index = pages.firstIndex(of: viewController), index > 0 else {
//            return nil
//        }
//        return pages[index - 1]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
//            return nil
//        }
//        return pages[index + 1]
//    }
//
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if completed, let currentVC = viewControllers?.first, let index = pages.firstIndex(of: currentVC) {
//            pageControl.currentPage = index
//        }
//    }
//}

