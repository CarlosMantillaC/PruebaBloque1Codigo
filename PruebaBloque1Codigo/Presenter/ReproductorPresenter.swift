//
//  ReproductorPresenter.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation

protocol ReproductorView: AnyObject {
    func recargarTabla()
}

class ReproductorPresenter {
    private let model = ReproductorModel()
    private let reproductorService: AudioPlayerService
    weak var view: ReproductorView?
    private var cancionActual: String?
    
    init(view: ReproductorView, reproductorService: AudioPlayerService) {
        self.view = view
        self.reproductorService = reproductorService
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
        reproductorService.play(nombre: nombre)
        cancionActual = nombre
        view?.recargarTabla()
    }
    
    func pausar() {
        reproductorService.pause()
    }

    func reanudar() {
        reproductorService.resume()
    }
    
    func estaReproduciendo() -> Bool {
        return reproductorService.isPlaying()
    }
    
    func reproducirAleatoria() {
        reproducir(nombre: cancionEn(index: model.random() - 1).title)
    }
    

   
}

