import io.ktor.client.*
import io.ktor.client.call.*
import io.ktor.client.request.*
import kotlinx.serialization.json.Json
import io.ktor.client.plugins.contentnegotiation.*
import io.ktor.serialization.kotlinx.json.*
import io.ktor.client.plugins.logging.*

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
        return client.get("https://jsonplaceholder.typicode.com/todos").body()
    }

    suspend fun getTodo(id: Int): Todo {
        return client.get("https://jsonplaceholder.typicode.com/todos/$id").body()
    }
}