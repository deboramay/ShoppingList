//
//  ViewController.swift
//  ShoppingList
//
//  Created by Anastasia on 26.04.2022.
//

import UIKit

class ViewController: UITableViewController {
  
  var shoppingList = [String]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Shopping List"
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(newList))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newItem))
    
    newList()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shoppingList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
    cell.textLabel?.text = shoppingList[indexPath.row]
    return cell
  }
  
  @objc func newList() {
    shoppingList.removeAll(keepingCapacity: true)
    tableView.reloadData()
  }
  
  @objc func newItem() {
    //Setup of alert controller
    let alertController = UIAlertController(title: "Add item", message: "Write an item", preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: "Cancel", style: .destructive))
    alertController.addTextField()
    
    let submitAction = UIAlertAction(title: "Add", style: .default) {
      [weak self, weak alertController] action in
      guard let item = alertController?.textFields?[0].text else { return }
      self?.submit(item.lowercased())
    }
    alertController.addAction(submitAction)
    
    //Presenting controller
    present(alertController, animated: true)
  }
  
  func submit(_ item: String) {
    let indexPath = IndexPath(row: 0, section: 0)
    shoppingList.insert(item, at: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
  }
}
