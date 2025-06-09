//
//  ViewControllerReproductor.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit
import AVFoundation


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
    
    private lazy var randomButton: UIButton = {
        
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Random"
        configuration.buttonSize = .large
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.random() }))
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(tableView)
        view.addSubview(randomButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: randomButton.topAnchor, constant: -10),
            
            randomButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10),
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
        let isReproduciendo = model.title == cancionActual
        cell.configure(model: model, isReproduciendo: isReproduciendo)
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
        
        if cancion.title == cancionActual {
            if let reproductor = reproductor, !reproductor.isPlaying {
                reproductor.play()
                print("reanudando")
                return
            }
        }
        
        reproducir(nombre: cancion.title)
        tableView.reloadData()

    }
    
    func pausarAccion(cell: TableViewCell) {

        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let cancion = canciones[indexPath.row]
        
        if cancion.title == cancionActual && reproductor?.isPlaying == true {
            reproductor?.pause()
            print("Pausando canción: \(cancion.title)")
            } else {
            print("La canción del botón no está sonando")
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

extension ViewControllerReproductor {
    
    
    private func random(n: Int = 0, divisor: Int = 2, acumulado: [String] = []) {
        
        if acumulado.count == 3 {
            let cancion = acumulado[acumulado.count-1]
            reproducir(nombre: cancion)
            tableView.reloadData()
            return
        }
        
        if n < 2 {
            random(n: n+1, acumulado: acumulado)
            return
        }
        
        if divisor*divisor > n {
            
            var nuevoAcumulado = acumulado
            nuevoAcumulado.append(canciones[n].title)
            random(n: n+1, divisor: 2, acumulado: nuevoAcumulado)
            return
        }
        
        if  n % divisor == 0 {
            random(n: n+1, acumulado: acumulado)
            return
        }
       
        return random(n: n, divisor: divisor+1, acumulado: acumulado)
        
    }
}
