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
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                ErrorView(error: error, tryAgain: viewModel.fetchTodos)
            } else {
                List(viewModel.todos, id: \.id) { todo in
                    NavigationLink(destination: TodoDetailView(todo: todo, onUpdate: { updatedTodo in
                        viewModel.updateTodo(updatedTodo)
                    })) {
                        HStack {
                            Button(action: {
                                viewModel.toggleTodoCompletion(todo)
                            }) {
                                Image(systemName: todo.isCompleted ? Constants.Images.checkmarkFill : Constants.Images.checkmarkEmpty)
                                    .foregroundColor(todo.isCompleted ? .green : .gray)
                            }
                            .buttonStyle(BorderlessButtonStyle())

                            Text(todo.title)
                                .strikethrough(todo.isCompleted, color: .gray)
                                .foregroundColor(todo.isCompleted ? .gray : .primary)
                        }
                    }
                }
                .navigationTitle(Constants.Strings.mainViewTitle)
                .onAppear {
                    if viewModel.todos.isEmpty {
                        viewModel.fetchTodos()
                    }
                }
            }
        }
    }
}
