import Foundation

enum DJLevel: String, CaseIterable {
    case beginner = "I'm new to DJing"
    case intermediate = "I've used DJ apps before"
    case professional = "I'm a professional DJ"
}

class UserRepository {
    private enum Keys {
        static let djLevel = "user_dj_level"
    }
    
    static let shared = UserRepository()
    private let defaults = UserDefaults.standard
    
    private init() {}
    
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