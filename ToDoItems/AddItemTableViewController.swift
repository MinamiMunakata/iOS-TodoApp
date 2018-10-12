//
//  AddItemTableViewController.swift
//  ToDoItems
//
//  Created by minami on 2018-10-11.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate: class { // = has to be a referance type (not struct)
    func addItemDidCancel()
    
    func addItemDidFinishAdding(_ item: TodoItem)
    
    func addItemDidFinishEditing(_ item: TodoItem)
}

class AddItemTableViewController: UITableViewController {
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    weak var delegate: AddItemViewControllerDelegate? // always weak
    weak var itemToEdit: TodoItem?

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.addItemDidCancel()
//        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        if let item = itemToEdit, let text = textField.text {
            item.text = text
            delegate?.addItemDidFinishEditing(item)
        } else {
            if let text = textField.text {
                let newItem = TodoItem()
                newItem.text = text
                newItem.checked = false
                delegate?.addItemDidFinishAdding(newItem)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // you can do them below in storyboard
//        textField.delegate = self
//        doneBarButton.isEnabled = false
        navigationItem.largeTitleDisplayMode = .never
        if let item = itemToEdit {
            title = "Edit Todo Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        // right before a user select the row
        return nil // nothing gonna be selected
    }
    
    override func viewWillAppear(_ animated: Bool) { // after viewDidLoad and right before display view
        textField.becomeFirstResponder()
    }

}

extension AddItemTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Unwrapping Optionals
        // 1. if-let
        // 2. guard
        guard let oldText = textField.text, let stringRange = Range(range, in: oldText) else { return false }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        doneBarButton.isEnabled = newText.isEmpty ? false : true
        
        return true

    }
}
