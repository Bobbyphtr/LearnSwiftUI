//
//  TodoService.swift
//  TodoList
//
//  Created by Bobby Pehtrus on 02/08/22.
//

import Foundation

enum LocalStorageKey {
    case todos
    
    public var key: String {
        switch self {
        case .todos:
            return "todos_list"
        }
    }
}

protocol TodoService {
    func save(_ todos: [Todo])
    func getTodos() -> [Todo]?
}

class TodoServiceDefault: TodoService {
    
    private let userDefaults: UserDefaults = UserDefaults.standard
    
    func save(_ todos: [Todo]) {
        if let encoded = try? JSONEncoder().encode(todos) {
            userDefaults.set(encoded, forKey: LocalStorageKey.todos.key)
        }
    }
    
    // Usually this could be an API response with error. You could return error as well.
    func getTodos() -> [Todo]? {
        guard
            let data = userDefaults.data(forKey: LocalStorageKey.todos.key),
            let savedItems = try? JSONDecoder().decode([Todo].self, from: data)
        else { return nil }
        return savedItems
    }
    
}
