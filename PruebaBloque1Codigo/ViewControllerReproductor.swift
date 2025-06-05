//
//  ViewControllerReproductor.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit
import AVFoundation

struct Cancion {
    let title: String
}

class ViewControllerReproductor: UIViewController {
    
    private var canciones: [Cancion] = [
        Cancion(title: "cancion1"),
        Cancion(title: "cancion2"),
        Cancion(title: "cancion3"),
        Cancion(title: "cancion4"),
        Cancion(title: "cancion5"),
        Cancion(title: "cancion6"),
    ]
    
    private var reproductor: AVAudioPlayer?
    private var cancionActual: String?
    
    private var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
    
        ])
    }


}

extension ViewControllerReproductor: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        canciones.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        let model = canciones[indexPath.row]
        cell.configure(model: model)
        cell.accionesBotones = self
        
        return cell
    }
}

extension ViewControllerReproductor: AccionesBotones {
    
    
    func reproducirAccion(cell: TableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let cancion = canciones[indexPath.row]
        reproducir(nombre: cancion.title)
    }
    
    func pausarAccion(cell: TableViewCell) {
        
        if reproductor?.isPlaying == true {
            reproductor?.pause()
            print("Pausa canción: \(cancionActual ?? "")")
            
        }
    }
    
}


extension ViewControllerReproductor {
    
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
        } catch {
            print("Error al reproducir la canción: \(error)")
        }
    }
}
