import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
data class Todo(
    val id: Int,
    val title: String,
    @SerialName("completed") val isCompleted: Boolean
)