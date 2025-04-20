//
//  Injection.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 20/04/2025.
//

import Factory

final class NavigationContainer: SharedContainer {
    static var shared = NavigationContainer()
    let manager = ContainerManager()
    
    var onBoardingCoordinator: Factory<OnboardingCoordinator> {
        self { OnboardingCoordinator() }.scope(.shared)
    }
}
