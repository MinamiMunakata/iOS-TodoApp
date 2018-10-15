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
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.allowsMultipleSelectionDuringEditing = true
        
        
    }
    
    @IBAction func deleteTodoItems(_ sender: UIBarButtonItem) {
        // check if there are any items selected
        if let selectedRows = tableView.indexPathsForSelectedRows {
            var items = [TodoItem]()
            for indexPath in selectedRows {
                items.append(todoList.todos[indexPath.row])
            }
            // remove from model
            todoList.remove(items: items)
            
            // remove from tableview
            tableView.beginUpdates() // because of multiple operations - don't change (the order) yet
            tableView.deleteRows(at: selectedRows, with: .automatic) // delete multiple rows
            tableView.endUpdates() // now you can change them!
        }

    }
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
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
        let item = todoList.todos[indexPath.row]
        configureCheckmark(for: cell, with: item)
        configureTodoLabel(for: cell, with: item)
        return cell
        
        
    }

    // MARK: TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return;
        }
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
        if let cell = cell as? TodoTableViewCell {
            cell.checkmark.text = item.checked ? "✔️" : ""
        }
    }
    
    func configureTodoLabel(for cell: UITableViewCell, with item: TodoItem) {
        if let cell = cell as? TodoTableViewCell {
            cell.todoLabel.text = item.text
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // remove from the model
        todoList.todos.remove(at: indexPath.row)
        // update the tableview
        tableView.deleteRows(at: [indexPath], with: .automatic)
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
            if let cell = tableView.cellForRow(at: indexPath) as? TodoTableViewCell {
                configureTodoLabel(for: cell, with: item)
            }
//            if let cell = tableView.cellForRow(at: indexPath),
//                let label = cell.viewWithTag(10) as? UILabel {
//                label.text = item.text
//            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
}
