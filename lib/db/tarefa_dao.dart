
import 'package:sqflite/sqflite.dart';
import 'package:todolist/db/database.dart';
import 'package:todolist/db/tarefa.dart';

class TarefaDao {

  final AppDatabase _app;

  TarefaDao(this._app);

  Future<void> insert(Tarefa tarefa) async {
    final db = await _app.database;
    await db.insert(
      'tarefas',
      tarefa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update(Tarefa tarefa) async {
    final db = await _app.database;
    await db.update(
      'tarefas',
      tarefa.toMap(),
      where: 'id = ?',
      whereArgs: [tarefa.id],
    );
  }

  Future<bool> delete(int id) async {
    final db = await _app.database;
    final result = await db.delete(
      'tarefas',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result > 0;
  }

  Future<List<Tarefa>> getAll() async {
    final db = await _app.database;
    final List<Map<String, dynamic>> tarefas = await db.query('tarefas');

    return tarefas.map((tarefa) => Tarefa.fromMap(tarefa)).toList();
  }

}
