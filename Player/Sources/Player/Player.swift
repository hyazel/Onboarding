//
//  Player.swift
//  DjLorenzo
//
//  Created by Laurent Droguet on 14/04/2025.
//

import Foundation
import AVFoundation

public final class Player {
    private var audioPlayer: AVAudioPlayer?
    
    public init() {}
}

public extension Player {
    var volume: Float {
        get { audioPlayer?.volume ?? 0 }
        set { audioPlayer?.volume = newValue }
    }
    
    func loadTrack(named name: String, extension ext: String = "mp3") throws {
        guard let url = Bundle.module.url(forResource: name, withExtension: ext) else {
            throw PlayerError.trackNotFound
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            
        } catch {
            throw PlayerError.failedToLoadTrack(error)
        }
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    func stop() {
        audioPlayer?.stop()
        audioPlayer?.currentTime = 0
    }
}

// MARK: - Errors
extension Player {
    enum PlayerError: Error {
        case trackNotFound
        case failedToLoadTrack(Error)
    }
}
