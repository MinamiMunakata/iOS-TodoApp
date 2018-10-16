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
    enum Priority: Int, CaseIterable {
        case high, medium, low
    }
    
    var highPriorityTodos: [TodoItem] = []
    var mediumPriorityTodos: [TodoItem] = []
    var lowPriorityTodos: [TodoItem] = []
    
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
        addTodo(item: item1, for: .high)
        addTodo(item: item2, for: .medium)
        addTodo(item: item3, for: .high)
        addTodo(item: item4, for: .low)
        addTodo(item: item5, for: .low)
    }
    
    func todoList(for priority: Priority) -> [TodoItem] {
        switch priority {
        case .high:
            return highPriorityTodos
        case .medium:
            return mediumPriorityTodos
        case .low:
            return lowPriorityTodos
        }
    }
    
    func addTodo(item: TodoItem, for priority: Priority, at index: Int = -1) { // default = -1
        switch priority {
        case .high:
            if index < 0 {
                highPriorityTodos.append(item)
            } else {
                highPriorityTodos.insert(item, at: index)
            }
        case .medium:
            if index < 0 {
                mediumPriorityTodos.append(item)
            } else {
                mediumPriorityTodos.insert(item, at: index)
            }
        case .low:
            if index < 0 {
                lowPriorityTodos.append(item)
            } else {
                lowPriorityTodos.insert(item, at: index)
            }
        }
    }
    
    func remove(item: TodoItem, from priority: Priority, at index: Int) {
        switch priority {
        case .high:
            highPriorityTodos.remove(at: index)
        case .medium:
            mediumPriorityTodos.remove(at: index)
        case .low:
            lowPriorityTodos.remove(at: index)
        }
    }
    
    func move(item: TodoItem, from srcPriority: Priority, at srcPath: IndexPath, to destPriority: Priority, at destPath: IndexPath) {
        remove(item: item, from: srcPriority, at: srcPath.row)
        addTodo(item: item, for: destPriority, at: destPath.row)
    }
}
