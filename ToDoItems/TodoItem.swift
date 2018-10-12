//
//  TodoItem.swift
//  ToDoItems
//
//  Created by minami on 2018-10-11.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import Foundation

class TodoItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleCheckmark() {
        self.checked = !self.checked
    }
}
