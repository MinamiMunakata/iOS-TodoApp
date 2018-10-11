//
//  ViewController.swift
//  ToDoItems
//
//  Created by minami on 2018-10-11.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import UIKit

class TodosViewController: UITableViewController {

    var todoList = TodoList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    // tableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // num of rows
        return todoList.todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // how each cell looks like
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath)
        // checkmark, todoLabel
        configureCheckmark(for: cell, with: todoList.todos[indexPath.row])
        
        if let todoLabel = cell.viewWithTag(10) as? UILabel {
            todoLabel.text = todoList.todos[indexPath.row].text
        }
        return cell
    }

    // MARK: TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // get the cell selected
        if let cell = tableView.cellForRow(at: indexPath) {
            // change the checked property of the TodoItem from model
            let item = todoList.todos[indexPath.row]
            item.toggleCheckmark()
            configureCheckmark(for: cell, with: item)
            // uncheck/check the checkmark from the cell
            
            
        }
        
        // deselect the row (no-highlighting)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: TodoItem) {
        if let checkmark = cell.viewWithTag(11) as? UILabel {
            checkmark.text = item.checked ? "✔️" : ""

        }
    }

}
