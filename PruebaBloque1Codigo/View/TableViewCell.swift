//
//  TableViewCell.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit

protocol AccionesBotones: AnyObject {
    func reproducirAccion(cell: TableViewCell)
    func pausarAccion(cell: TableViewCell)
}

class TableViewCell: UITableViewCell {
    
    weak var accionesBotones: AccionesBotones?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private var isReproduciendo: Bool = false {
        didSet {
            nameLabel.textColor = isReproduciendo ? .systemBlue : .label
        }
    }
    
    private lazy var botonReproducir: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.reproducirAccionBoton() }))
        let image = UIImage(systemName: "play.fill")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var botonPausar: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.pausarAccionBoton() }))
        let image = UIImage(systemName: "pause.fill")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [nameLabel, botonReproducir, botonPausar].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            botonReproducir.trailingAnchor.constraint(equalTo: botonPausar.leadingAnchor, constant: -10),
            botonReproducir.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            botonReproducir.widthAnchor.constraint(equalToConstant: 40),
            
            botonPausar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            botonPausar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            botonPausar.widthAnchor.constraint(equalToConstant: 40),

        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(model: Cancion, isReproduciendo: Bool) {
        nameLabel.text = model.title
        self.isReproduciendo = isReproduciendo
    }
    
    private func reproducirAccionBoton() {
        accionesBotones?.reproducirAccion(cell: self)
    }
    
    private func pausarAccionBoton() {
        accionesBotones?.pausarAccion(cell: self)
    }
}
