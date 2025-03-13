//
//  TodoDetailView.swift
//  iosApp
//
//  Created by Patrik Cesnek on 11/03/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import shared
import SwiftUI

struct TodoDetailView: View {
    let todo: Todo
    let onUpdate: (Todo) -> Void
    
    @State private var isEditing = false
    @State private var editedTitle: String
    @State private var isCompleted: Bool
    
    init(todo: Todo, onUpdate: @escaping (Todo) -> Void) {
        self.todo = todo
        self.onUpdate = onUpdate
        self._editedTitle = State(initialValue: todo.title)
        self._isCompleted = State(initialValue: todo.isCompleted)
    }
    
    var body: some View {
        Form {
            Section {
                TextField(Constants.Strings.title, text: $editedTitle)
                    .disabled(!isEditing)
                
                Toggle(Constants.Strings.completedToggle, isOn: $isCompleted)
                    .disabled(!isEditing)
            }
            
            Section {
                Text(Constants.Strings.hint)
                    .font(.caption)
            }
        }
        .navigationTitle(Constants.Strings.detailTitle)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button(isEditing ? Constants.Strings.save : Constants.Strings.edit) {
                if isEditing {
                    let updatedTodo = Todo(
                        userId: todo.userId,
                        id: todo.id,
                        title: editedTitle,
                        isCompleted: isCompleted
                    )
                    onUpdate(updatedTodo)
                }
                isEditing.toggle()
            }
        }
    }
}
