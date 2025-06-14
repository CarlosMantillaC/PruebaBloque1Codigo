//
//  Cancion.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation
import AVFoundation


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
