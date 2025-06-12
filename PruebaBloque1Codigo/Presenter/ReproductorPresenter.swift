//
//  ReproductorPresenter.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation
import AVFoundation

protocol ReproductorView: AnyObject {
    func recargarTabla()
}

class ReproductorPresenter {
    private let model = ReproductorModel()
    weak var view: ReproductorView?
    private var reproductor: AVAudioPlayer?
    
    
    private var cancionActual: String?
    
    init(view: ReproductorView) {
        self.view = view
    }
    
    func numeroDeCanciones() -> Int {
        return model.obtenerCanciones().count
    }
    
    func cancionEn(index: Int) -> Cancion {
        return model.obtenerCanciones()[index]
    }
    
    func cancionActualTitulo() -> String? {
        return cancionActual
    }
    
    func reproducir(nombre: String) {
        guard let url = Bundle.main.url(forResource: nombre, withExtension: "mp3") else {
            print("No se encontró el archivo \(nombre).mp3")
            return
        }
        do {
            reproductor = try AVAudioPlayer(contentsOf: url)
            reproductor?.play()
            cancionActual = nombre
            print("Reproduciendo: \(nombre)")
            view?.recargarTabla()
        } catch {
            print("Error al reproducir la canción: \(error)")
        }
    }
    
    func pausar() {
        reproductor?.pause()
    }

    func reanudar() {
        reproductor?.play()
    }
    
    func estaReproduciendo() -> Bool {
        return reproductor?.isPlaying ?? false
    }
    
    func reproducirAleatoria() {
        
        reproducir(nombre: cancionEn(index: random()-1).title)
     }

    private func random(n: Int = 0, divisor: Int = 2, acumulado: [Int] = []) -> Int {
        
        if acumulado.count == 3 {
            return acumulado[acumulado.count-1]
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
