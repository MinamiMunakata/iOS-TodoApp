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
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // change model
//        todoList.move(item: todoList.todos[sourceIndexPath.row], to: destinationIndexPath.row)
        // update tableview
        tableView.reloadData() // calls datasource methods again.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItemSegue" {
            if let addItemVC = segue.destination as? AddItemTableViewController  {
                addItemVC.delegate = self
            }
        } else if segue.identifier == "EditItemSegue" {
            if let addItemVC = segue.destination as? AddItemTableViewController {
                if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell),
                    let priority = priorityForSectionIndex(indexPath.section){
//                    let item = todoList.todos[indexPath.row]
                    let item = todoList.todoList(for: priority)[indexPath.row]
                    addItemVC.itemToEdit = item
                    addItemVC.delegate = self
                }
            }
        }
    }
    
    private func priorityForSectionIndex(_ index: Int) -> TodoList.Priority? {
        return TodoList.Priority(rawValue: index)
    }
    
    // MARK: tableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TodoList.Priority.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // num of rows
        if let priority = priorityForSectionIndex(section) {
            return todoList.todoList(for: priority).count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // how each cell looks like
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath)
        // checkmark, todoLabel
        if let priority = priorityForSectionIndex(indexPath.section) {
            let  items = todoList.todoList(for: priority)
            let item = items[indexPath.row]
            configureCheckmark(for: cell, with: item)
            configureTodoLabel(for: cell, with: item)
        }
        return cell
        
        
    }

    // MARK: TableViewDelegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String? = nil
        if let priority = priorityForSectionIndex(section) {
            switch priority {
            case .high:
                title = "HIGH PRIORITY"
            case .medium:
                title = "MEDIUM PRIORITY"
            case .low:
                title = "LOW PRIORITY"
            }
        }
        return title
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEditing {
            return;
        }
        // get the cell selected
        if let cell = tableView.cellForRow(at: indexPath) {
            // change the checked property of the TodoItem from model
            if let priority = priorityForSectionIndex(indexPath.section) {
                let  items = todoList.todoList(for: priority)
                let item = items[indexPath.row]
                item.toggleCheckmark()
                // uncheck/check the checkmark from the cell
                configureCheckmark(for: cell, with: item)
                // deselect the row (no-highlighting)
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
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
        if let priority = priorityForSectionIndex(indexPath.section) {
            let item = todoList.todoList(for: priority)[indexPath.row]
            todoList.remove(item: item, from: priority, at: indexPath.row)
        }
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
        todoList.addTodo(item: item, for: .medium)
        
        // update view
        let index = todoList.todoList(for: .medium).count - 1
        let indexPath = IndexPath(row: index, section: TodoList.Priority.medium.rawValue)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    func addItemDidFinishEditing(_ item: TodoItem) {
        // what is the index of "item" from todos array.
        // update model
        for priority in TodoList.Priority.allCases {
            var priorityArray = todoList.todoList(for: priority)
            if let index = priorityArray.index(of: item) {
                priorityArray[index] = item
                let indexPath = IndexPath(row: index, section: priority.rawValue)
                if let cell = tableView.cellForRow(at: indexPath) {
                    configureTodoLabel(for: cell, with: item)
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
