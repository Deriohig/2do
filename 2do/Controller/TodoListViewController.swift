//
//  ViewController.swift
//  2do
//
//  Created by Deri on 3/27/18.
//  Copyright © 2018 Deri O'hUiginn. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("ListItems.plist")
    var items = [ListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem =  ListItem()
        newItem.name = "Buy foods"
        items.append(newItem)
        
        let newItem2 =  ListItem()
        newItem2.name = "Eat foods"
        items.append(newItem2)
        
        let newItem3 =  ListItem()
        newItem3.name = "Eat more foods"
        items.append(newItem3)
        
        loadItems()
//        if let itemArray = defaults.array(forKey: "listItems") as? [ListItem]{
//            items = itemArray
//        }
        // Do any additional setup after loading the view, typically from a nib.
     }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    //MARK - Populate row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        cell.textLabel?.text = item.name
        
        cell.accessoryType = item.checked ? .checkmark : .none
        
        return cell
    }
    
    //MARK - Select Row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        items[indexPath.row].checked = !items[indexPath.row].checked
        
        saveItems()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - addrow
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Item", message:"", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default){
            (action) in
            let newItem =  ListItem()
            newItem.name = textField.text!
            self.items.append(newItem)
            self.saveItems()
        }
        alert.addAction(action)
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "New Item"
            textField = alertTextField
            
        }
        
        present(alert, animated:true, completion: nil)
        
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath!)
            
        }catch{
            print("Errir encouding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
             try items = decoder.decode([ListItem].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
            }
        }
    }
    
    
}

