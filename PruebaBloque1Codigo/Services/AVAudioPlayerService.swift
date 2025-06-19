//
//  AVAudioPlayerService.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 14/06/25.
//

import Foundation
import AVFoundation

class AVAudioPlayerService: AudioPlayerService {
    private var player: AVAudioPlayer?
    
    func play(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("File not found: \(name).mp3")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("Playing: \(name)")
        } catch {
            print("Error playing audio: \(error)")
        }
    }
    
    func pause() {
        player?.pause()
        print("Slow song")
    }
    
    func resume() {
        player?.play()
        print("Resuming song")
    }
    
    func isPlaying() -> Bool {
        return player?.isPlaying ?? false
    }
}
