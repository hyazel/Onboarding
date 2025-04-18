//
//  Injection.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 18/04/2025.
//

import Factory

final class RepositoryContainer: SharedContainer {
    static var shared = RepositoryContainer()
    let manager = ContainerManager()
    
    var userRepository: Factory<UserRepository> {
        self { UserRepositoryImpl() }
    }
}
