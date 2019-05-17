//
//  PokedexDetailViewController.swift
//  Pokedex
//
//  Created by Hayden Hastings on 5/17/19.
//  Copyright © 2019 Hayden Hastings. All rights reserved.
//

import UIKit

class PokedexDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var pokedexSearchbar: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var typesLabel: UILabel!
    
    @IBOutlet weak var pokedexImageView: UIImageView!
}
