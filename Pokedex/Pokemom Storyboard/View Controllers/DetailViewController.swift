//
//  DetailViewController.swift
//  Pokemom Storyboard
//
//  Created by Alex Rhodes on 9/6/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let pokedexController = PokedexController()
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var savePokemonButton: UIButton!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var types: UILabel!
    @IBOutlet weak var abilities: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        nameLabel.isHidden = true
        idLabel.isHidden = true
        typesLabel.isHidden = true
        abilitiesLabel.isHidden = true
        savePokemonButton.isHidden = true
        id.isHidden = true
        types.isHidden = true
        abilities.isHidden = true
    }
    

    
    func setViews() {
        
        nameLabel.isHidden = false
        idLabel.isHidden = false
        typesLabel.isHidden = false
        abilitiesLabel.isHidden = false
        savePokemonButton.isHidden = false
        id.isHidden = false
        types.isHidden = false
        abilities.isHidden = false
        
        savePokemonButton.backgroundColor = #colorLiteral(red: 1, green: 0.01453149226, blue: 0, alpha: 1)
        savePokemonButton.setTitle("SAVE POKEMON", for: .normal)
        savePokemonButton.setTitleColor(.white, for: .normal)
        
        guard let pokemon = pokedexController.pokemon else {return}
        
        idLabel.text = String(pokemon.id)
        nameLabel.text = pokemon.name
        
        var types = ""
        let typeArray = pokemon.types
        
        for type in typeArray {
            types.append("\(type)")
            types.append(", ")
        }
        
        typesLabel.text = types
        abilitiesLabel.text = "\(pokemon.abilities)"
        
        let url = URL(string: pokemon.sprites.frontDefault)!
        if let image = try? Data(contentsOf: url) {
             imageView.image = UIImage(data: image)
        }
       
        
    }
    
    @IBAction func savePokemonButton(_ sender: Any) {
        
    }
    
}

extension DetailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        guard let searchTerm = searchBar.text else {return}
        
        pokedexController.preformSearch(with: searchTerm) { (error) in
            DispatchQueue.main.async {
                self.setViews()
            }
        }
    }
}
