//
//  ViewControllerReproductor.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit

class ReproductiveViewController: UIViewController {
    var reproductivePresenter: ReproductivePresenter
    
    init(reproductivePresenter: ReproductivePresenter = ReproductivePresenter()) {
        self.reproductivePresenter = reproductivePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { [weak self] _ in self?.reproductivePresenter.randomSong() }))
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reproductivePresenter.attachView(self)

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
        reproductivePresenter.numberSongs()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let model = reproductivePresenter.songIn(index: indexPath.row)
        let isReproduciendo = model.title == reproductivePresenter.currentSongTitle()
        cell.configure(model: model, isReproduciendo: isReproduciendo)
        cell.actionButtons = self
        
        return cell
    }
}

extension ReproductiveViewController: ActionButtons {
    func playAction(cell: TableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let song = reproductivePresenter.songIn(index: indexPath.row)
        if song.title == reproductivePresenter.currentSongTitle() {
            if !reproductivePresenter.isPlaying() {
                reproductivePresenter.resume()
                return
            }
        }
        reproductivePresenter.reproduce(name: song.title)
    }
    
    func pauseAction(cell: TableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        let song = reproductivePresenter.songIn(index: indexPath.row)
        
        if song.title == reproductivePresenter.currentSongTitle() && reproductivePresenter.isPlaying() == true {
            reproductivePresenter.pause()
        }
    }
}
