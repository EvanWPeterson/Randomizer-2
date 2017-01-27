//
//  EntitiesTableViewController.swift
//  Randomizer-2
//
//  Created by Evan Peterson on 1/27/17.
//  Copyright © 2017 Evan Peterson. All rights reserved.
//

import UIKit
import GameKit

class EntitiesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }



    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Group \([section + 1][0])"
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return (EntitiesController.shared.pairPeople.count)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntitiesController.shared.pairPeople[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        
        let entity = EntitiesController.shared.pairPeople[indexPath.section][indexPath.row]
        cell.textLabel?.text = entity.person


        return cell
    }
    
    func rando() {
        EntitiesController.shared.entities.random()
        tableView.reloadData()
    }
 
    @IBAction func RandomizeButtonTapped(_ sender: Any) {
        rando()

    }
        
    @IBAction func addButtonTapped(_ sender: Any) {
    
        var nameTextField: UITextField?
        
        let alert = UIAlertController(title: "Add Person", message: "Add a new person to the list", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Full Name"
            textField.keyboardType = .default
            nameTextField = textField
            
            let addAction = UIAlertAction(title: "Add", style: .default, handler: { (textField) in
                guard let nameText = nameTextField?.text else { return }
                
                EntitiesController.shared.add(entity: nameText)
                self.tableView.reloadData()
            })
            let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addAction(addAction)
            alert.addAction(dismissAction)
            
            self.present(alert, animated: true, completion: nil)
        }
    
    }

}

extension Array {
    mutating func random() {
        for _ in 0..<10 { sort { (_,_) in arc4random() < arc4random() } }
    }
}
