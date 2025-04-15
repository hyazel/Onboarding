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
    
    var isPlaying: Bool {
        audioPlayer?.isPlaying ?? false
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

// MARK: - Usage Example
extension Player {
    static func example() {
        let player = Player()
        
        do {
            // Load track from bundle
            try player.loadTrack(named: "song", extension: "mp3")
            
            // Set volume (0.0 to 1.0)
            player.volume = 0.8
            
            // Play
            player.play()
            
            // Check if playing
            if player.isPlaying {
                // Pause
                player.pause()
            }
            
            // Stop and reset to beginning
            player.stop()
            
        } catch Player.PlayerError.trackNotFound {
            print("Track not found in bundle")
        } catch Player.PlayerError.failedToLoadTrack(let error) {
            print("Failed to load track:", error)
        } catch {
            print("Unknown error:", error)
        }
    }
} 
