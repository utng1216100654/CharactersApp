//
//  CharactersModel.swift
//  CharactersApp
//
//  Created by Amairany Servin Salazar on 4/24/19.
//  Copyright © 2019 Amairany Servin Salazar. All rights reserved.
//

class CharactersModel{
    var id: String?
    var name: String?
    var skill: String?
    var weakness: String?
    var universe: String?
    
    init(id:String?, name:String?, skill:String?, weakness:String?, universe:String?){
        self.id = id;
        self.name = name;
        self.skill = skill;
        self.weakness = weakness;
        self.universe = universe;
    }
}
