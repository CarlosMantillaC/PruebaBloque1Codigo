//
//  AudioPlayerService.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 14/06/25.
//

import Foundation


protocol AudioPlayerService {
    func play(name: String)
    func pause()
    func resume()
    func isPlaying() -> Bool
}
