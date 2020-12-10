//
//  MarvelView.swift
//  Marvel
//
//  Created by nithindev.narayanan on 10/12/20.
//

import UIKit

class MarvelView: UIView {


    var marvelTableView: UITableView
    var noDataLabel: UILabel
    override init(frame: CGRect) {
        
        marvelTableView = UITableView()
        marvelTableView.isHidden = true
        marvelTableView.tableFooterView = UIView()
        
        noDataLabel = UILabel()
        noDataLabel.font = UIFont.systemFont(ofSize: 15)
        noDataLabel.text = "Tap on + button to add random MARVEL character."
        noDataLabel.numberOfLines = 0
        noDataLabel.textAlignment = .center
        noDataLabel.isHidden = false
        
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubViewsForAutoLayout([noDataLabel, marvelTableView])
        
        addConstraints()
    }
    
    required init?(coder: NSCoder) {

        fatalError("init(coder:) has not been implemented")
    }
    
    func showHideTableView(_ show: Bool) {
        
        marvelTableView.isHidden = !show
        noDataLabel.isHidden = show
    }
    
    func addConstraints() {
        
        NSLayoutConstraint.activate([
            marvelTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            marvelTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            marvelTableView.topAnchor.constraint(equalTo: topAnchor),
            marvelTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            noDataLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            noDataLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            noDataLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
