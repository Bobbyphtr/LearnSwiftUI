//
//  Todo.swift
//  TodoList
//
//  Created by Bobby Pehtrus on 02/08/22.
//

import Foundation

struct Todo: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString,
         title: String,
         isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompletion() -> Todo {
        return Todo(id:id, title: title, isCompleted: !isCompleted)
    }
}
