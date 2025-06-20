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
    private let model: ReproductiveModel
    weak var view: ReproductiveView?
    private let reproductiveService: AudioPlayerService
    private var currentSong: String?
    
    init(model: ReproductiveModel = ReproductiveModel(), reproductorService: AudioPlayerService = AVAudioPlayerService()) {
        self.model = model
        self.reproductiveService = reproductorService
    }
    
    func attachView(_ view: ReproductiveView) {
        self.view = view
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

