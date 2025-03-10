class TodoRepository(private val apiService: TodoApiService) {
    suspend fun fetchTodos(): List<Todo> = apiService.getTodos()
    suspend fun fetchTodoDetail(id: Int): Todo = apiService.getTodo(id)
}