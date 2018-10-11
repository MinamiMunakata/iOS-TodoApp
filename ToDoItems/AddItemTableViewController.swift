//
//  AddItemTableViewController.swift
//  ToDoItems
//
//  Created by minami on 2018-10-11.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
    }
    
    override func viewWillAppear(_ animated: Bool) { // after viewDidLoad and right before display view
        textField.becomeFirstResponder()
    }

}
