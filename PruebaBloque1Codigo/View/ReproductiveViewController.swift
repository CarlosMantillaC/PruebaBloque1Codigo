//
//  ViewControllerReproductor.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit

class ReproductiveViewController: UIViewController {
    var reproductivePresenter: ReproductivePresenter?
    
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
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in self?.reproductivePresenter?.randomSong() }))
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reproductivePresenter = ReproductivePresenter(view: self)

        view.backgroundColor = .systemBackground
        
        [tableView, randomButton].forEach(view.addSubview)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: randomButton.topAnchor, constant: -10),
            
            randomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            randomButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension ReproductiveViewController: ReproductiveView {
    func reloadTable() {
        tableView.reloadData()
    }
}

extension ReproductiveViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reproductivePresenter?.numberSongs() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        guard let presenter = reproductivePresenter else {
            return cell
        }
        let model = presenter.songIn(index: indexPath.row)
        let isReproduciendo = model.title == presenter.currentSongTitle()
        cell.configure(model: model, isReproduciendo: isReproduciendo)
        cell.actionButtons = self
        
        return cell
    }
}

extension ReproductiveViewController: ActionButtons {
    func playAction(cell: TableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
              let presenter = reproductivePresenter else {
            return
        }
        let song = presenter.songIn(index: indexPath.row)
        if song.title == presenter.currentSongTitle() {
            if !presenter.isPlaying() {
                presenter.resume()
                return
            }
        }
        presenter.reproduce(name: song.title)
    }
    
    func pauseAction(cell: TableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell),
              let presenter = reproductivePresenter else {
            return
        }
        let song = presenter.songIn(index: indexPath.row)
        
        if song.title == presenter.currentSongTitle() && presenter.isPlaying() == true {
            presenter.pause()
        }
    }
}
