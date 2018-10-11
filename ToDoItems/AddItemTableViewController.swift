//
//  AddItemTableViewController.swift
//  ToDoItems
//
//  Created by minami on 2018-10-11.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBAction func done(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // you can do them below in storyboard
//        textField.delegate = self
//        doneBarButton.isEnabled = false
        navigationItem.largeTitleDisplayMode = .never
        
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
