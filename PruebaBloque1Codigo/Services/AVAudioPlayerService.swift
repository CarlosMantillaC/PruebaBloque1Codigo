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
    
    func play(nombre: String) {
        guard let url = Bundle.main.url(forResource: nombre, withExtension: "mp3") else {
            print("No se encontró el archivo: \(nombre).mp3")
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            print("Reproduciendo: \(nombre)")
        } catch {
            print("Error al reproducir el audio: \(error)")
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func resume() {
        player?.play()
    }
    
    func isPlaying() -> Bool {
        return player?.isPlaying ?? false
    }
    
}
