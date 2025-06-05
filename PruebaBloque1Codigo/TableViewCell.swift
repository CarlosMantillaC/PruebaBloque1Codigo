//
//  TableViewCell.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit

protocol AccionesBotones: AnyObject {
    func reproducirAccion(on cell: TableViewCell)
    func pausarAccion(on cell: TableViewCell)
}

class TableViewCell: UITableViewCell {

    weak var accionesBotones: AccionesBotones?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    private let botonReproducir: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("▶️", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let botonPausar: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("⏸️", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(botonReproducir)
        contentView.addSubview(botonPausar)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            botonPausar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            botonPausar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            botonPausar.widthAnchor.constraint(equalToConstant: 40),
            
            botonReproducir.trailingAnchor.constraint(equalTo: botonPausar.leadingAnchor, constant: -10),
            botonReproducir.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            botonReproducir.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        botonReproducir.addTarget(self, action: #selector(reproducirAccionBoton), for: .touchUpInside)
        botonPausar.addTarget(self, action: #selector(pausarAccionBoton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(model: Cancion) {
        nameLabel.text = model.title
    }
    
    @objc private func reproducirAccionBoton() {
        accionesBotones?.reproducirAccion(on: self)
    }
    
    @objc private func pausarAccionBoton() {
        accionesBotones?.pausarAccion(on: self)
    }
}
