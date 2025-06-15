//
//  ReproductivePresenter.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 9/06/25.
//

import Foundation

protocol ReproductiveView: AnyObject {
    func reloadTable()
}

class ReproductivePresenter {
    private let model = ReproductiveModel()
    private let reproductiveService: AudioPlayerService
    weak var view: ReproductiveView?
    private var currentSong: String?
    
    init(view: ReproductiveView, reproductorService: AudioPlayerService = AVAudioPlayerService()) {
        self.view = view
        self.reproductiveService = reproductorService
    }
    
    func numberSongs() -> Int {
        return model.getSongs().count
    }
    
    func songIn(index: Int) -> Song {
        return model.getSongs()[index]
    }
    
    func currentSongTitle() -> String? {
        return currentSong
    }
    
    func reproduce(name: String) {
        reproductiveService.play(name: name)
        currentSong = name
        view?.reloadTable()
    }
    
    func pause() {
        reproductiveService.pause()
    }

    func resume() {
        reproductiveService.resume()
    }
    
    func isPlaying() -> Bool {
        return reproductiveService.isPlaying()
    }
    
    func randomSong() {
        reproduce(name: songIn(index: model.random() - 1).title)
    }
    
}

