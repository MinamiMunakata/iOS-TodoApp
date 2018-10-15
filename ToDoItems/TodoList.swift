//
//  TodoList.swift
//  ToDoList
//
//  Created by minami on 2018-10-11.
//  Copyright © 2018 宗像三奈美. All rights reserved.
//

import Foundation

class TodoList {
    var todos: [TodoItem] = []
    
    init() {
        let item1 = TodoItem()
        item1.text = "Take a walk"
        item1.checked = true
        let item2 = TodoItem()
        item2.text = "study"
        let item3 = TodoItem()
        item3.text = "fix resume"
        let item4 = TodoItem()
        item4.checked = true
        item4.text = "watch Netflix"
        let item5 = TodoItem()
        item5.text = "study design"
        todos.append(item1)
        todos.append(item2)
        todos.append(item3)
        todos.append(item4)
        todos.append(item5)
    }
    
    func remove(items: [TodoItem]) {
        for item in items {
            if let index = todos.index(of: item) {
                todos.remove(at: index)
            }
        }
    }
}
