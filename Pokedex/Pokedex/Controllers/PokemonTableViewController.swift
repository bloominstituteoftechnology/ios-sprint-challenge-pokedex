//
//  PokemonTableViewController.swift
//  Pokedex
//
//  Created by Sal Amer on 1/24/20.
//  Copyright © 2020 Sal Amer. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {
    
    let apiController = APIController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return apiController.pokemonsArray.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath)
        let pokemonResults = apiController.pokemonsArray[indexPath.row]
        cell.textLabel?.text = pokemonResults.name
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            apiController.pokemonsArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "SearchBtnSegue" {
            if let detailVC = segue.destination as? DetailViewController {
                detailVC.apiController = apiController
            }
        }
        
        if segue.identifier == "DetailViewSegue" {
            guard let detailVC = segue.destination as? DetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.
            
        }
    }
  

}
