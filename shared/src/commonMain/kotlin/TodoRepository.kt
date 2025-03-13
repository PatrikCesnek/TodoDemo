import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

class TodoRepository(private val apiService: TodoApiService) {
    suspend fun fetchTodos(): List<Todo> = withContext(Dispatchers.Main) {
        apiService.getTodos()
    }

    suspend fun fetchTodoDetail(id: Int): Todo = withContext(Dispatchers.Main) {
        apiService.getTodo(id)
    }

    suspend fun updateTodo(todo: Todo): Todo {
        return apiService.updateTodo(todo)
    }
}
