//
//  ViewController.swift
//  2do
//
//  Created by Deri on 3/27/18.
//  Copyright © 2018 Deri O'hUiginn. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    
    var items = ["Buy foods","eat foods","eat more foods"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let itemArray = defaults.array(forKey: "listItemArray") as? [String]{
            items = itemArray
        }
        // Do any additional setup after loading the view, typically from a nib.
     }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //MARK - Populate row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    //MARK - Select Row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - addrow
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){
            (action) in
            
            self.items.append(textField.text!)
            self.defaults.set(self.items , forKey: "listItemArray")
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            textField = alertTextField
            
        }
        
        present(alert, animated:true, completion: nil)
        
    }
    

}

