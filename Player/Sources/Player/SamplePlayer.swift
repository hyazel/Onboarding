//
//  SamplePlayer.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import Foundation
import AudioToolbox

public enum Sample: String {
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

public class SamplePlayer {
    public static func play(_ sample: Sample) {
        AudioServicesPlaySystemSound(sample.soundID)
    }
} 
