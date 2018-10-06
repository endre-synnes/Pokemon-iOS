//
//  FirstViewController.swift
//  MyPokemons
//
//  Created by Endre Mikal Synnes on 04/10/2018.
//  Copyright © 2018 Endre Mikal Synnes. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let names = [
        "Bulbasaur", "Ivysaur", "Venusar", "Charmender", "Charmeleon", "Charizard",
        "Bulbasaur", "Ivysaur", "Venusar", "Charmender", "Charmeleon", "Charizard",
        "Bulbasaur", "Ivysaur", "Venusar", "Charmender", "Charmeleon", "Charizard",
        "Bulbasaur", "Ivysaur", "Venusar", "Charmender", "Charmeleon", "Charizard",
        "Bulbasaur", "Ivysaur", "Venusar", "Charmender", "Charmeleon", "Charizard"
        ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width / 4
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: width, height: width)
        //Do any additional setup after loading the view, typically from a nib.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
        
        cell.pokemonName.text = names[indexPath.item]
        
        let url = URL(string: "https://www.serebii.net/pokemongo/pokemon/001.png")
        
        URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            DispatchQueue.main.async {
                cell.pokemonImg.image = UIImage(data: data!)
            }
            
        }.resume()
        
        
        
        //do {
        //    let url = URL(string: "http://verona-api.municipiumstaging.it/system/images/image/image/22/app_1920_1280_4.jpg")
       //     let data = try Data(contentsOf: url!)
       //     cell.pokemonImg.image = UIImage(data: data)
        //}
        //catch{
         //   print(error)
        //}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    

}

