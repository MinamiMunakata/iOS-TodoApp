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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemVC = segue.destination as? AddItemTableViewController  {
                addItemVC.delegate = self
            }
        } else if segue.identifier == "EditItemSegue" {
            if let addItemVC = segue.destination as? AddItemTableViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
                    let item = todoList.todos[indexPath.row]
                    addItemVC.itemToEdit = item
                    addItemVC.delegate = self
                }
            }
        }
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

extension TodosViewController: AddItemViewControllerDelegate {
    func addItemDidCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemDidFinishAdding(_ item: TodoItem) {
        // pop
        navigationController?.popViewController(animated: true)
        
        // update model
        todoList.todos.append(item)
        
        // update view
        let index = todoList.todos.count - 1
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func addItemDidFinishEditing(_ item: TodoItem) {
        // what is the index of "item" from todos array.
        // update model
        if let index = todoList.todos.index(of: item) {
            todoList.todos[index] = item
            // update tableView
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath),
                let label = cell.viewWithTag(10) as? UILabel {
                label.text = item.text
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
