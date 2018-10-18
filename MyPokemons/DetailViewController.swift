//
//  DetailViewController.swift
//  MyPokemons
//
//  Created by Endre Mikal Synnes on 13/10/2018.
//  Copyright © 2018 Endre Mikal Synnes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var pokemon: PokemonModel = PokemonModel()
    
    var name = ""
    
    var image = UIImage()

    
    @IBOutlet weak var pokemonImg: UIImageView!
    
    @IBOutlet weak var PokemonName: UILabel!
    
    @IBOutlet weak var exitBtnOutlet: UIButton!
    
    @IBAction func exitDetailBtn(_ sender: UIButton) {
        //sender.layer.cornerRadius = 30
        //sender.contentView.layer.cornerRadius = 30.0
        //sender.contentView.layer.borderWidth = 1.0
        //sender.contentView.layer.borderColor = UIColor.clear.cgColor
        //sender.contentView.layer.masksToBounds = true
        //sender.layer.shadowColor = UIColor.lightGray.cgColor
        //sender.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        //sender.layer.shadowRadius = 2.0
        //sender.layer.shadowOpacity = 0.3
        //sender.layer.masksToBounds = false
        //sender.layer.shadowPath = UIBezierPath(roundedRect: sender.bounds, cornerRadius: sender.contentView.layer.cornerRadius).cgPath
        
        //sender.backgroundColor = UIColor.red
        
        
        
        self.dismiss(animated: true, completion: nil)
        self.navigationController?.popToViewController(FirstViewController(), animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exitBtnOutlet.layer.cornerRadius = 23;
        //exitBtnOutlet.layer.shadowColor = UIColor.lightGray.cgColor
        exitBtnOutlet.backgroundColor = ColorConverter.hexStringToUIColor(hex: "#45BEA2")
        
        
        pokemonImg.image = image
        PokemonName.text = name
    }
}
