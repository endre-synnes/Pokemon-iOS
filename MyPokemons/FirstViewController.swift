//
//  FirstViewController.swift
//  MyPokemons
//
//  Created by Endre Mikal Synnes on 04/10/2018.
//  Copyright © 2018 Endre Mikal Synnes. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var pokemons = [PokemonModel]()
    
    var currentPokemon = PokemonModel()
    
    let url = "https://my-pokemon-api.herokuapp.com/api/pokemon?limit=151"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width / 4
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: width, height: width)
        getPokemonData(url: url)
    }
    
    func reloadPokemons(){
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(pokemons.count)
        return pokemons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.contentView.layer.cornerRadius = 30.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        cell.pokemonName.text = pokemons[indexPath.item].name
        let imgUrl = URL(string: pokemons[indexPath.item].img)
        cell.pokemon = pokemons[indexPath.item]
        
        URLSession.shared.dataTask(with: imgUrl!) {
            (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                let img = UIImage(data: data!)
                cell.pokemonImg.image = img
                self.pokemons[indexPath.item].imageView = img
            }
            
        }.resume()
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        currentPokemon = pokemons[indexPath.item]
        performSegue(withIdentifier: "details", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsView = segue.destination as! DetailViewController
        detailsView.pokemon = currentPokemon
        detailsView.image = currentPokemon.imageView!
        detailsView.name = currentPokemon.name
    }
    
    func getPokemonData(url: String) {
        
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success!")
                
                let pokemonJSON : JSON = JSON(response.result.value!)
                self.parceJSON(json: pokemonJSON)
                
                self.reloadPokemons()
                
            } else {
                print("Error \(String(describing: response.result.error))")
            }
        }
    }
    
    
    func parceJSON(json: JSON) {
        let list = json["data"]["list"].arrayValue
        pokemons = list.map({parsePokemon(json: $0)})
    }
    
    
    func parsePokemon(json: JSON) -> PokemonModel {
        let pokemon = PokemonModel()
        
        pokemon.name = json["name"].stringValue
        pokemon.candy_count = json["candy_count"].intValue
        pokemon.egg = json["egg"].stringValue
        pokemon.id = json["id"].stringValue
        pokemon.img = json["img"].stringValue
        pokemon.num = json["num"].stringValue
        pokemon.prev_evolution = json["prev_evolution"].arrayValue.map({$0["num"].stringValue})
        pokemon.next_evolution = json["next_evolution"].arrayValue.map({$0["num"].stringValue})
        
        return pokemon
    }

}

