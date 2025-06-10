//
//  Cancion.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation

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

