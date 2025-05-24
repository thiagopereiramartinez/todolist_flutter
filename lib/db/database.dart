import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todolist/db/tarefa_dao.dart';

class AppDatabase {

  late final Database _database;
  final Completer<Database> _dbCompleter = Completer();

  AppDatabase() {
    _init();
  }

  Future<void> _init() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todolist.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tarefas(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, createdAt TEXT, completed INTEGER)',
        );
      },
      version: 1,
    );
    _dbCompleter.complete(_database);
  }

  Future<Database> get database => _dbCompleter.future;

  TarefaDao get tarefaDao => TarefaDao(this);

}
