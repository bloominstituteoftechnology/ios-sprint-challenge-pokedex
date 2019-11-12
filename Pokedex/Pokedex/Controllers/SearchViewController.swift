//
//  SearchViewController.swift
//  Pokedex
//
//  Created by Aaron on 9/14/19.
//  Copyright © 2019 AlphaGrade, INC. All rights reserved.
//

import UIKit



class SearchViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    @IBOutlet weak var abilitiesLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    
    var protocolDelegate: AddPokemonDelegate?
    var delegate: [Pokemon]?
    var newPokemon: Pokemon?
    var apiController = APIController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        clearView()
        // Do any additional setup after loading the view.
    }
    
 


    @IBAction func savePokemonTapped(_ sender: Any) {
        guard let addPokemon = apiController.myPokemon else {return}
   
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
        protocolDelegate?.pokemonWasAdded(addPokemon)

    }
    
    func clearView() {
        if let newPokemon = newPokemon  {
            idLabel.text = String(newPokemon.id)
            typesLabel.text = newPokemon.types?[0].type?.name
            abilitiesLabel.text = newPokemon.abilities[0].ability?.name
            nameLabel.text = newPokemon.name
            guard let image = newPokemon.sprites?.frontDefault else {return}
            let url = URL(string: image)!
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                self.pokemonImage.image = UIImage(data: imageData)
            }
        } else {
            idLabel.text = "ID:"
            abilitiesLabel.text = "Abilities:"
            nameLabel.text = "Pokemon"
        }
    }
    func updateViews() {
        
        if let newPokemon = apiController.myPokemon {
          
            let id = String(newPokemon.id)
            let abilityCount = newPokemon.abilities.count
            guard let ability = newPokemon.abilities[0].ability?.name else { return }
            var allAbilities = ""
            for number in 0...abilityCount-1 {
                if abilityCount == 1 {
                    allAbilities = ability
                    break
                }
                guard let addedAbility = newPokemon.abilities[number].ability?.name else { return }
                allAbilities = "\(ability), \(addedAbility)"
            }
            guard let typecount = newPokemon.types?.count else {return}
            guard let type = newPokemon.types?[0].type?.name else { return }
            var newType = ""
            for number in 0...typecount-1 {
                if typecount == 1 {
                    newType = type
                    break}
                guard let addedType = newPokemon.types?[number].type?.name else {return}
                newType = "\(type), \(addedType)"
            }
            DispatchQueue.main.async {
                self.idLabel.text = "ID: \(id)"
                self.nameLabel.text = newPokemon.name
                self.typesLabel.text = "Type: \(newType)"
                self.abilitiesLabel.text = "Abilites: \(allAbilities)"
                guard let image = newPokemon.sprites?.frontDefault else {return}
                //Image
                let url = URL(string: image)!
                let data = try? Data(contentsOf: url)
                
                if let imageData = data {
                    self.pokemonImage.image = UIImage(data: imageData)
                }
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        let lowercase = searchTerm.lowercased()
        apiController.performSearch(searchTerm: lowercase) { error in
            if let error = error {
                print("There was an error: \(error)")
                return
            }
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
       
    }
    
}
