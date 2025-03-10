//
//  TodoListViewModel.swift
//  iosApp
//
//  Created by Patrik Cesnek on 10/03/2025.
//  Copyright © 2025 orgName. All rights reserved.
//


import Foundation
import shared
import Combine

class TodoListViewModel: ObservableObject {
    @Published var todos: [Todo] = []
    
    private let repository = TodoRepository(apiService: TodoApiService())
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchTodos()
    }
    
    func fetchTodos() {
        Task {
            do {
                let fetchedTodos = try await repository.fetchTodos()
                DispatchQueue.main.async {
                    self.todos = fetchedTodos
                }
            } catch {
                print("Failed to fetch todos: \(error)")
            }
        }
    }

    func toggleTodoCompletion(_ todo: Todo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index] = Todo(id: todo.id, title: todo.title, isCompleted: !todo.isCompleted)
        }
    }
}
