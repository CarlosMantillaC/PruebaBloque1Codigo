//
//  ReproductiveModel.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation

class ReproductiveModel {
    private var songs: [Song] = [
        Song(title: "cancion1"),
        Song(title: "cancion2"),
        Song(title: "cancion3"),
        Song(title: "cancion4"),
        Song(title: "cancion5"),
        Song(title: "cancion6")
    ]
    
    func getSongs() -> [Song] {
        return songs
    }
    
    func random(n: Int = 0, divider: Int = 2, accumulated: [Int] = []) -> Int {
        if accumulated.count == 3 {
            return accumulated.last!
        }
        
        if n < 2 {
            return random(n: n+1, accumulated: accumulated)
        }
        
        if divider * divider > n {
            var newAccumulated = accumulated
            newAccumulated.append(n)
            
            return random(n: n+1, divider: 2, accumulated: newAccumulated)
        }
        
        if n % divider == 0 {
            return random(n: n+1, accumulated: accumulated)
        }
        
        return random(n: n, divider: divider+1, accumulated: accumulated)
    }
}
