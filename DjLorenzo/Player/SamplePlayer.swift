import Foundation
import AudioToolbox

enum Sample: String {
    case kick = "kick"
    case snare = "snare"
    case horn = "horn"
    case stageIntro = "stageintro"
    
    var soundID: SystemSoundID {
        var id: SystemSoundID = 0
        if let path = Bundle.main.path(forResource: self.rawValue, ofType: "wav") {
            AudioServicesCreateSystemSoundID(URL(fileURLWithPath: path) as CFURL, &id)
        }
        return id
    }
}

class SamplePlayer {
    static func play(_ sample: Sample) {
        AudioServicesPlaySystemSound(sample.soundID)
    }
} 