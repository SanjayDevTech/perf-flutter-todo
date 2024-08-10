import 'package:floor/floor.dart';
import 'todo_entity.dart';

@dao
abstract class TodoDao {
  @Query("SELECT * FROM todos")
  Stream<List<TodoEntity>> getAll();

  @Query("SELECT * FROM todos WHERE id = :id")
  Stream<TodoEntity?> get(int id);

  @Insert()
  Future<void> insert(TodoEntity todo);

  @Update()
  Future<void> update(TodoEntity todo);

  @Query("DELETE FROM todos WHERE id = :id")
  Future<void> delete(int id);
}
