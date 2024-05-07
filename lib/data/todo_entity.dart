import 'package:floor/floor.dart';

@Entity(tableName: "todos")
class TodoEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String content;
  TodoEntity(this.id, this.content);

  TodoEntity copyWith({
    int? id,
    String? content,
  }) {
    return TodoEntity(id ?? this.id, content ?? this.content);
  }
}
