import 'package:flutter/material.dart';
import 'package:todolist/db/database.dart';
import 'package:todolist/db/tarefa.dart';
import 'package:todolist/db/tarefa_dao.dart';
import 'package:todolist/tarefa_item.dart';

class ListaTarefas extends StatefulWidget {
  const ListaTarefas({super.key});

  @override
  State<ListaTarefas> createState() => ListaTarefasState();
}

class ListaTarefasState extends State<ListaTarefas> {
  final TarefaDao _tarefaDao = TarefaDao(AppDatabase());

  void atualizarLista() {
    setState(() {});
  }

  Future<void> _concluirTarefa(Tarefa tarefa) async {
    tarefa.completed = true;
    await _tarefaDao.update(tarefa);
  }

  Future<void> _desmarcarTarefa(Tarefa tarefa) async {
    tarefa.completed = false;
    await _tarefaDao.update(tarefa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Tarefa>>(
      future: _tarefaDao.getAll(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final tarefas = snapshot.data!;
          tarefas.sort((a, b) {
            if (a.completed != b.completed) {
              return a.completed ? 1 : -1;
            }
            return a.createdAt.compareTo(b.createdAt);
          });

          if (tarefas.isEmpty) {
            return Center(child: Text('Nenhuma tarefa adicionada.'));
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: ListView.builder(
              itemCount: tarefas.length,
              itemBuilder: (context, index) {
                final tarefa = tarefas[index];
                return TarefaItem(
                  tarefa: tarefa,
                  onDelete: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    await _tarefaDao.delete(tarefa.id!);
                    setState(() {
                      tarefas.removeAt(index);
                    });
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Tarefa removida'),
                        duration: Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  onCheckChanged: (value) async {
                    if (value == true) {
                      await _concluirTarefa(tarefa);
                    } else {
                      await _desmarcarTarefa(tarefa);
                    }
                    setState(() {
                      tarefa.completed = value!;
                    });
                  },
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
