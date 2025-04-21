//
//  UserRepository.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import Foundation

public enum DJLevel: String, CaseIterable {
    case beginner = "I'm new to DJing"
    case intermediate = "I've used DJ apps before"
    case professional = "I'm a professional DJ"
}


public protocol UserRepository {
    func saveDJLevel(_ level: DJLevel)
    func getDJLevel() -> DJLevel?
    func clearDJLevel()
}

final class UserRepositoryImpl: UserRepository {
    private enum Keys {
        static let djLevel = "user_dj_level"
    }
    
    private let defaults = UserDefaults.standard
    
    init() {}
    
    func saveDJLevel(_ level: DJLevel) {
        defaults.set(level.rawValue, forKey: Keys.djLevel)
    }
    
    func getDJLevel() -> DJLevel? {
        guard let levelString = defaults.string(forKey: Keys.djLevel) else {
            return nil
        }
        return DJLevel(rawValue: levelString)
    }
    
    func clearDJLevel() {
        defaults.removeObject(forKey: Keys.djLevel)
    }
} 
