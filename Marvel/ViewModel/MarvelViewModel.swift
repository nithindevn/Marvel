//
//  MarvelViewModel.swift
//  Marvel
//
//  Created by nithindev.narayanan on 10/12/20.
//

import Foundation
protocol ViewModelLogic {
    
    func loadAvailableCharacters()
    func getRandomCharacter() -> Hero?
    func loadSavedCharacters()
    func saveCharacter(_ name: String) -> Bool
    func deleteCharacter(_ index: Int)
}
class MarvelViewModel: ViewModelLogic {
    
    var availableCharacters: [Hero] = []
    var selectedCharacters: [Hero] = []

    func loadAvailableCharacters() {
        
        let filename = "Marvel"
        guard let confPath = Bundle.main.url(forResource: filename, withExtension: "json") else { return }
        guard let fileData = try? Data(contentsOf: confPath) else { return }
        
        let decoder = JSONDecoder()
        
        do {

            let model = try decoder.decode(MarvelModel.self, from: fileData)
            
            availableCharacters = model.characters
        } catch {

            return
        }
    }
    
    func getRandomCharacter() -> Hero? {
        
        guard !availableCharacters.isEmpty else { return nil }
        let index = Int.random(in: 0..<availableCharacters.count)
        
        return availableCharacters[index]
    }
    
    func loadSavedCharacters() {
        
        let characterNames = PermanentStore().readCharactersFromFile()
        selectedCharacters = []
        for name in characterNames {
            
            if let hero = availableCharacters.filter({ $0.name == name }).first {
                
                selectedCharacters.append(hero)
            }
        }
    }
    
    func saveCharacter(_ name: String) -> Bool {
        
        var characterNames = selectedCharacters.map { $0.name }
        characterNames.append(name)
        if PermanentStore().saveCharactersToFile(characterNames) {
            
            loadSavedCharacters()
            return true
        } else {
            
           print("Failure")
            return false
        }
    }
    
    func deleteCharacter(_ index: Int) {
        
        selectedCharacters.remove(at: index)
        let characterNames = selectedCharacters.map { $0.name }
        
        if PermanentStore().saveCharactersToFile(characterNames) {
            
            loadSavedCharacters()
        } else {
            
           print("Failure")
        }
    }
}
