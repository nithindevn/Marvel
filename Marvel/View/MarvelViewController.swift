//
//  ViewController.swift
//  Marvel
//
//  Created by nithindev.narayanan on 10/12/20.
//

import UIKit

class MarvelViewController: UIViewController {

    var sceneView = MarvelView()
    var viewModel = MarvelViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        self.title = "Marvel"
        
        sceneView.marvelTableView.register(MarvelTableViewCell.self, forCellReuseIdentifier: "marvelCell")
        
        viewModel.loadAvailableCharacters()
        viewModel.loadSavedCharacters()
        
        sceneView.showHideTableView(!viewModel.selectedCharacters.isEmpty)
        
        sceneView.marvelTableView.dataSource = self
        sceneView.marvelTableView.delegate = self
    }
    
    override func loadView() {
        
        view = sceneView
    }
    
    @objc func addTapped() {
        
        if let character = viewModel.getRandomCharacter() {
            
            if viewModel.saveCharacter(character.name) {
                
                sceneView.marvelTableView.reloadData()
            }

            sceneView.showHideTableView(!viewModel.selectedCharacters.isEmpty)
        }
    }
}

extension MarvelViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.selectedCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "marvelCell") as? MarvelTableViewCell {
            
            cell.fillData(viewModel.selectedCharacters[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            viewModel.deleteCharacter(indexPath.row)
            sceneView.marvelTableView.reloadData()
            sceneView.showHideTableView(!viewModel.selectedCharacters.isEmpty)
        }
    }
}
