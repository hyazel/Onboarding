//
//  Injection.swift
//  Player
//
//  Created by Laurent Droguet on 18/04/2025.
//

import Factory

public final class RepositoryContainer: SharedContainer {
    public static var shared = RepositoryContainer()
    public let manager = ContainerManager()
    
    public var userRepository: Factory<UserRepository> {
        self { UserRepositoryImpl() }
    }
}
