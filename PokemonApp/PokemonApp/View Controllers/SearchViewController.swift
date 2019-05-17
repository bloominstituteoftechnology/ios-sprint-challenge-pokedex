//
//  SearchViewController.swift
//  PokemonApp
//
//  Created by Diante Lewis-Jolley on 5/17/19.
//  Copyright © 2019 Diante Lewis-Jolley. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        idLabel.text = .isHidden
        typeLabel.text = .isHidden
        abilityLabel.text = .isHidden


    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }

        pokemonController.fetchPokemon(with: searchTerm.lowercased()) { (pokemon, error) in
            if let error = error {
                NSLog("Error searching pokemon: \(error)")
                return
            }

            if let pokemon = pokemon {
                DispatchQueue.main.async {
                    self.pokemon = pokemon
                    self.updateViews()
                }

                self.pokemonController.fetchImages(pokemon: pokemon, completion: { (image, error) in
                    if let error = error {
                        NSLog("Error searching Images: \(error)")
                        return
                    }

                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                })
            }
        }

    }

    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let pokemon = pokemon else { return }

        pokemonController.create(pokemon: pokemon)
        navigationController?.popToRootViewController(animated: true)
    }

    private func updateViews() {

        guard let pokemon = pokemon else { return }
        idLabel.text = "ID: \(pokemon.id)"
        typeLabel.text = "Type: \(pokemon.types.map {$0.type.name})"
        abilityLabel.text = "Abilities: \(pokemon.abilities.map {$0.ability.name})"

    }
    
    


    let pokemonController = PokemonController()
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }



}
