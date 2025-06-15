//
//  TableViewCell.swift
//  PruebaBloque1Codigo
//
//  Created by Gopenux on 5/06/25.
//

import UIKit

protocol ActionButtons: AnyObject {
    func playAction(cell: TableViewCell)
    func pauseAction(cell: TableViewCell)
}

class TableViewCell: UITableViewCell {
    
    weak var actionButtons: ActionButtons?
    
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
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.playButtonTapped() }))
        let image = UIImage(systemName: "play.fill")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var pauseButton: UIButton = {
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.pauseButtonTapped() }))
        let image = UIImage(systemName: "pause.fill")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        [nameLabel, playButton, pauseButton].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            playButton.trailingAnchor.constraint(equalTo: pauseButton.leadingAnchor, constant: -10),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 40),
            
            pauseButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            pauseButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pauseButton.widthAnchor.constraint(equalToConstant: 40),

        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(model: Song, isReproduciendo: Bool) {
        nameLabel.text = model.title
        self.isReproduciendo = isReproduciendo
    }
    
    private func playButtonTapped() {
        actionButtons?.playAction(cell: self)
    }
    
    private func pauseButtonTapped() {
        actionButtons?.pauseAction(cell: self)
    }
}
