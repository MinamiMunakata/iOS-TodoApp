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
    
    func addTodo(item: TodoItem, for priority: Priority) {
        switch priority {
        case .high:
            highPriorityTodos.append(item)
        case .medium:
            mediumPriorityTodos.append(item)
        case .low:
            lowPriorityTodos.append(item)
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
    
    func remove(items: [TodoItem]) {
        for item in items {
            if let index = todos.index(of: item) {
                todos.remove(at: index)
            }
        }
    }
    
    func move(item: TodoItem, to index: Int) {
//        if let currentIndex = todos.index(of: item) {
//            todos.remove(at: currentIndex)
//            todos.insert(item, at: index)
//        }
    }
}
