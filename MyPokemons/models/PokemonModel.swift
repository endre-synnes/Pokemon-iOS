//
//  PokemonModel.swift
//  MyPokemons
//
//  Created by Endre Mikal Synnes on 06/10/2018.
//  Copyright © 2018 Endre Mikal Synnes. All rights reserved.
//

import UIKit

class PokemonModel {
    var id : String = ""
    var num : String = ""
    var name : String = ""
    var img : String = ""
    var candy_count : Int? = nil
    var egg : String = ""
    var type : [String]? = nil
    var weaknesses : [String]? = nil
    var prev_evolution : [EvolutionModel]? = nil
    var next_evolution : [EvolutionModel]? = nil
}
