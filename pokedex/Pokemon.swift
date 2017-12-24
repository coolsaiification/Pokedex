//
//  File.swift
//  pokedex
//
//  Created by Sai on 08/10/17.
//  Copyright © 2017 Sai. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name:String!
    private var _pokedexId:Int!
    private var _description:String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvolutionText:String!
    private var _pokemonURL:String!
    
    var nextEvolutionText:String{
        if _nextEvolutionText==nil{
            _nextEvolutionText=""
        }
        return _nextEvolutionText
    }
    var weight:String{
        if _weight==nil{
            _weight=""
        }
        return _weight
    }
    var height:String{
        if _height==nil{
            _height=""
        }
        return _height
    }
    var attack:String{
        if _attack==nil{
            _attack=""
        }
        return _attack
    }
    var defense:String{
        if _defense==nil{
            _defense=""
        }
        return _defense
    }
    var type:String{
        if _type==nil{
            _type=""
        }
        return _type
    }
    var description:String{
        if _description==nil{
            _description=""
        }
        return _description
    }
    
    var name:String{
        return _name
    }
    var pokedexId:Int{
        return _pokedexId
    }
    
    init(name:String, pokedexId:Int) {
        self._name=name
        self._pokedexId=pokedexId
        
        self._pokemonURL="\(URL_BASE)\(URL_Pokemon)\(self._pokedexId!)/"
    }
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        print(self._pokemonURL!)
        Alamofire.request(self._pokemonURL).responseJSON{ (response) in
            if let dict = response.result.value as? Dictionary<String,AnyObject>{
                
                if let weight = dict["weight"] as? Int{
                    self._weight = "\(weight)"
                }
                if let height = dict["height"] as? Int{
                    self._height = "\(height)"
                }
                if let att = dict["stats"]?[4] as? Dictionary<String,AnyObject>{
                    if let attack = att["base_stat"] as? Int{
                        self._attack = "\(attack)"
                    }
                }
                if let def = dict["stats"]?[3] as? Dictionary<String,AnyObject>{
                    if let defense = def["base_stat"] as? Int{
                        self._defense = "\(defense)"
                    }
                }
                if let typ = dict["types"] as? [Dictionary<String,AnyObject>] , typ.count>0 {
                    if let name = typ[0]["type"]?["name"] as? String{
                        print(name)
                        self._type = "\(name.capitalized)"
                    }
                    for x in 1..<typ.count{
                        if let name = typ[x]["type"]?["name"] as? String{
                            print(name)
                            self._type! += "/\(name.capitalized)"
                        }
                    }
                    print(self._type)
                }
                
            }
            completed()
        }
    }
}
