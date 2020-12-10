//
//  MarvelTableViewCell.swift
//  Marvel
//
//  Created by nithindev.narayanan on 10/12/20.
//

import UIKit

class MarvelTableViewCell: UITableViewCell {

    private let cellView = MarvelCellView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubviewForAutolayout(cellView)
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fillData(_ data: Hero) {
        
        cellView.imageView.image = UIImage(named: data.image)
        cellView.titleLabel.text = data.name
        cellView.descriptionLabel.text = data.desc
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            cellView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
