//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by Stephanie Bowles on 6/2/19.
//  Copyright © 2019 Stephanie Bowles. All rights reserved.
//

import UIKit

class PokedexTableViewController: UITableViewController {

  
    let pokemonController = PokemonController()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.reloadData()
    }

    // MARK: - Table view data source
 

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonController.pokemonList.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokeCell", for: indexPath) as! PokedexTableViewCell
        let pokemon = pokemonController.pokemonList[indexPath.row]
        
        cell.pokeNameLabel.text = pokemon.name.capitalized
        
        guard let url = URL(string: pokemon.sprites.frontDefault),
            let pokemonImageData = try? Data(contentsOf: url) else { return UITableViewCell() }
        cell.spriteView.image = UIImage(data: pokemonImageData)
        return cell
    }
   

    

   
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            pokemonController.deletePokemon(pokemonIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
      
    }
 

    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
