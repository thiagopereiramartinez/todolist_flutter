import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'db/tarefa.dart';

class TarefaItem extends StatelessWidget {
  final Tarefa tarefa;
  final VoidCallback onDelete;
  final ValueChanged<bool?> onCheckChanged;

  const TarefaItem({
    super.key,
    required this.tarefa,
    required this.onDelete,
    required this.onCheckChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Dismissible(
        key: Key(tarefa.id.toString()),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: const Icon(Icons.delete, color: Colors.white),
        ),
        onDismissed: (_) => onDelete(),
        child: Card(
          elevation: .5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: const Color(0xFFF9FAFB),
          child: ListTile(
            leading: Checkbox(value: tarefa.completed, onChanged: onCheckChanged),
            title: Text(
              tarefa.title,
              style: tarefa.completed
                  ? const TextStyle(decoration: TextDecoration.lineThrough)
                  : null,
            ),
            subtitle: Text(
              'Criado em: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(tarefa.createdAt))}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }
}
