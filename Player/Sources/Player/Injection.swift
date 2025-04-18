//
//  Injection.swift
//  Player
//
//  Created by Laurent Droguet on 18/04/2025.
//

import Factory

public final class PlayerContainer: SharedContainer {
    public static var shared = PlayerContainer()
    public let manager = ContainerManager()
    
    public var player: Factory<Player> {
        self { Player() }
    }
}
