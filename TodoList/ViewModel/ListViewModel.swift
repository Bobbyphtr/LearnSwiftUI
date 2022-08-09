//
//  ListViewModel.swift
//  TodoList
//
//  Created by Bobby Pehtrus on 01/08/22.
//

import Foundation

class ListViewModel: ObservableObject {
    
    @Published var items: [Todo] = [] {
        didSet {
            saveItems()
        }
    }
    
    private let service: TodoService
    
    init(service: TodoService = TodoServiceDefault()) {
        self.service = service
        
        getItems()
    }
    
    func getItems() {
        let newItems : [Todo] = service.getTodos() ?? []
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)

    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItems(title: String) {
        let newTodo = Todo(title: title, isCompleted: false)
        items.append(newTodo)
    }
    
    func updateItem(item: Todo) {
        if let index: Int = items.firstIndex(where: { $0.id == item.id }) {
             items[index] = item.updateCompletion()
        }
    }
    
    func saveItems() {
        service.save(items)
    }
    
}
