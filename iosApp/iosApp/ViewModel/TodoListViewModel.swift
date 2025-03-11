//
//  TodoListViewModel.swift
//  iosApp
//
//  Created by Patrik Cesnek on 10/03/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Combine
import shared
import SwiftUI

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    
    private let repository = TodoRepository(apiService: TodoApiService())

    @MainActor
    func fetchTodos() {
        Task {
            do {
                let fetchedTodos = try await repository.fetchTodos()
                self.todos = fetchedTodos
            } catch {
                print("Error fetching todos: \(error)")
            }
        }
    }

    func toggleTodoCompletion(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            let updatedTodo = Todo(userId: todo.userId, id: todo.id, title: todo.title, isCompleted: !todo.isCompleted)
            todos[index] = updatedTodo
        }
    }
    
    func updateTodo(_ updatedTodo: Todo) {
        if let index = todos.firstIndex(where: { $0.id == updatedTodo.id }) {
            todos[index] = updatedTodo
        }
    }
}
