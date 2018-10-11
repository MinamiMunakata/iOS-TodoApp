//
//  ViewController.swift
//  ToDoItems
//
//  Created by minami on 2018-10-11.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import UIKit

class TodosViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    // tableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // num of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // how each cell looks like
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItem", for: indexPath)
        // checkmark, todoLabel
        if let checkmark = cell.viewWithTag(11) as? UILabel {
            checkmark.text = ""
        }
        
        if let todoLabel = cell.viewWithTag(10) as? UILabel {
            todoLabel.text = "Study iOS development"
        }
        return cell
    }


}

