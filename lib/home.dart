import 'package:flutter/material.dart';
import 'package:todolist/db/database.dart';
import 'adicionar_tarefa.dart';
import 'appbar.dart';
import 'db/tarefa.dart';
import 'db/tarefa_dao.dart';
import 'lista_tarefas.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TarefaDao _tarefaDao = TarefaDao(AppDatabase());
  final GlobalKey<ListaTarefasState> _listaKey = GlobalKey<ListaTarefasState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarApp(),
      body: ListaTarefas(key: _listaKey),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _adicionarTarefa((tarefa) async {
            final tarefaModel = Tarefa(
              title: tarefa,
              createdAt: DateTime.now().toString(),
              completed: false,
            );
            await _tarefaDao.insert(tarefaModel);
            _listaKey.currentState?.atualizarLista();
          });
        },
        isExtended: true,
        label: Text("Adicionar tarefa"),
        icon: Icon(Icons.add),
      ),
      resizeToAvoidBottomInset: true,
    );
  }

  void _adicionarTarefa(Function(String) onSave) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom:
                MediaQuery.of(context).viewInsets.bottom +
                MediaQuery.of(context).padding.bottom,
          ),
          child: AdicionarTarefa(onSave: onSave),
        );
      },
    );
  }
}
