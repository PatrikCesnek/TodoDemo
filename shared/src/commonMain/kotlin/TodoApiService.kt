
import io.ktor.client.HttpClient
import io.ktor.client.call.body
import io.ktor.client.plugins.contentnegotiation.ContentNegotiation
import io.ktor.client.plugins.logging.DEFAULT
import io.ktor.client.plugins.logging.LogLevel
import io.ktor.client.plugins.logging.Logger
import io.ktor.client.plugins.logging.Logging
import io.ktor.client.request.get
import io.ktor.client.request.put
import io.ktor.client.request.setBody
import io.ktor.client.statement.HttpResponse
import io.ktor.http.ContentType
import io.ktor.http.contentType
import io.ktor.serialization.kotlinx.json.json
import kotlinx.serialization.json.Json

class TodoApiService {
    private val client = HttpClient {
        install(ContentNegotiation) {
            json(Json { ignoreUnknownKeys = true })
        }

        install(Logging) {
            logger = Logger.DEFAULT
            level = LogLevel.INFO
        }
    }

    suspend fun getTodos(): List<Todo> {
        val response: String = client.get("https://jsonplaceholder.typicode.com/todos").body()
        println("Raw API Response: $response")
        return Json.decodeFromString(response)
    }

    suspend fun getTodo(id: Int): Todo {
        return client.get("https://jsonplaceholder.typicode.com/todos/$id").body()
    }

    suspend fun updateTodo(todo: Todo): Todo {
        println("Updating todo with ID: ${todo.id}")

        return try {
            val response: HttpResponse = client.put("https://jsonplaceholder.typicode.com/todos/${todo.id}") {
                contentType(ContentType.Application.Json)
                setBody(Json.encodeToString(Todo.serializer(), todo))
            }

            println("Response status: ${response.status}")

            response.body()
        } catch (e: Exception) {
            println("Error updating todo: ${e.message}")
            throw e
        }
    }

}