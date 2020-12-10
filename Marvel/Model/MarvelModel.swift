//
//  MarvelModel.swift
//  Marvel
//
//  Created by nithindev.narayanan on 10/12/20.
//

import Foundation

struct MarvelModel: Decodable {
    
    var characters: [Hero]
    
    
    enum CodingKeys: String, CodingKey {

        case characters
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        characters = try values.decodeIfPresent([Hero].self, forKey: .characters) ?? []
    }
}

struct Hero: Decodable {
    
    var name: String
    var image: String
    var desc: String
    
    enum CodingKeys: String, CodingKey {

        case name
        case image
        case desc
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        image = try values.decodeIfPresent(String.self, forKey: .image) ?? ""
        desc = try values.decodeIfPresent(String.self, forKey: .desc) ?? ""
    }
    
    init(name: String, image: String, desc: String) {
        
        self.name = name
        self.desc = desc
        self.image = image
    }
    
}
