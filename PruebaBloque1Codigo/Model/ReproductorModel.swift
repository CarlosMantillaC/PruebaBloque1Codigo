//
//  Cancion.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation
import AVFoundation

struct Cancion {
    let title: String
}

class ReproductorModel {
    private(set) var canciones: [Cancion] = [
        Cancion(title: "cancion1"),
        Cancion(title: "cancion2"),
        Cancion(title: "cancion3"),
        Cancion(title: "cancion4"),
        Cancion(title: "cancion5"),
        Cancion(title: "cancion6")
    ]
    
    func obtenerCanciones() -> [Cancion] {
        return canciones
    }
    
}

protocol AudioPlayerService {
    func play(nombre: String)
    func pause()
    func resume()
    func isPlaying() -> Bool
}

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


extension ReproductorModel {
    
    func random(n: Int = 0, divisor: Int = 2, acumulado: [Int] = []) -> Int {
        if acumulado.count == 3 {
            return acumulado.last!
        }
        if n < 2 {
            return random(n: n+1, acumulado: acumulado)
        }
        if divisor * divisor > n {
            var nuevoAcumulado = acumulado
            nuevoAcumulado.append(n)
            return random(n: n+1, divisor: 2, acumulado: nuevoAcumulado)
        }
        if n % divisor == 0 {
            return random(n: n+1, acumulado: acumulado)
        }
        return random(n: n, divisor: divisor+1, acumulado: acumulado)
    }
}
