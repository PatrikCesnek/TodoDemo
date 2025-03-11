//
//  TodoListView.swift
//  iosApp
//
//  Created by Patrik Cesnek on 10/03/2025.
//  Copyright © 2025 orgName. All rights reserved.
//


import SwiftUI

struct TodoListView: View {
    @StateObject private var viewModel = TodoListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.todos, id: \.id) { todo in
                HStack {
                    Button(action: {
                        viewModel.toggleTodoCompletion(todo)
                    }) {
                        Image(systemName: todo.isCompleted ? "checkmark.square.fill" : "square")
                            .foregroundColor(todo.isCompleted ? .green : .gray)
                    }
                    .buttonStyle(BorderlessButtonStyle())

                    Text(todo.title)
                        .strikethrough(todo.isCompleted, color: .gray)
                        .foregroundColor(todo.isCompleted ? .gray : .primary)
                }
            }
            .navigationTitle("To-Do List")
            .onAppear {
                viewModel.fetchTodos()
            }
        }
    }
}
