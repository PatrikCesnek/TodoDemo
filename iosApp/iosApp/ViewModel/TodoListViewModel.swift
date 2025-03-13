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

@MainActor
class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    @Published var isLoading = false
    @Published var error: String?
    
    private let repository = TodoRepository(apiService: TodoApiService())

    func fetchTodos() {
        isLoading = true
        Task {
            do {
                self.error = nil
                let fetchedTodos = try await repository.fetchTodos()
                self.todos = fetchedTodos
                isLoading = false
            } catch {
                self.error = error.localizedDescription
                isLoading = false
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
            self.todos = todos
            Task {
                do {
                    self.error = nil
                    try await repository.updateTodo(todo: updatedTodo)
                } catch {
                    self.error = error.localizedDescription
                }
            }
        }
    }
}
