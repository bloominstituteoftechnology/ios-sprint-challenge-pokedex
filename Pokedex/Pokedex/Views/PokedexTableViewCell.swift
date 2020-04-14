//
//  PokedexTableViewCell.swift
//  Pokedex
//
//  Created by Cody Morley on 4/10/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit

class PokedexTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonNameLabel: UILabel?
    
    var pokemon: Pokemon? {
        didSet {
            updateViews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateViews() {
        guard let unwrappedPokemon = pokemon else { return }
        pokemonNameLabel?.text = unwrappedPokemon.name
    }
}
