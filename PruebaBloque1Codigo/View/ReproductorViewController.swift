//
//  ViewControllerReproductor.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit

class ReproductorViewController: UIViewController {
    
    var reproductorPresenter: ReproductorPresenter!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
        
    private lazy var randomButton: UIButton = {
        
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Random"
        configuration.buttonSize = .large
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.reproductorPresenter.reproducirAleatoria() }))
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        view.addSubview(randomButton)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: randomButton.topAnchor, constant: -10),
            
            randomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        reproductorPresenter = ReproductorPresenter(view: self)
    }
}

extension ReproductorViewController: ReproductorView {
    
    func recargarTabla() {
        tableView.reloadData()
    }
}


extension ReproductorViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (reproductorPresenter?.numeroDeCanciones())!
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
                
        let model = reproductorPresenter.cancionEn(index: indexPath.row)
        let isReproduciendo = model.title == reproductorPresenter.cancionActualTitulo()
        
        cell.configure(model: model, isReproduciendo: isReproduciendo)
        cell.accionesBotones = self
        
        return cell
    }
}

extension ReproductorViewController: AccionesBotones {
    
    func reproducirAccion(cell: TableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let cancion = reproductorPresenter.cancionEn(index: indexPath.row)
        
        if cancion.title == reproductorPresenter.cancionActualTitulo() {
            if !reproductorPresenter.estaReproduciendo() {
                reproductorPresenter.reanudar()
                print("reanudando")
                return
            }
        }
        
        reproductorPresenter.reproducir(nombre: cancion.title)
        recargarTabla()
    }
    
    func pausarAccion(cell: TableViewCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let cancion = reproductorPresenter.cancionEn(index: indexPath.row)
        
        if cancion.title == reproductorPresenter.cancionActualTitulo() && reproductorPresenter.estaReproduciendo() == true {
            reproductorPresenter.pausar()
            print("pausando")
            
        }
        
    }
    
}
