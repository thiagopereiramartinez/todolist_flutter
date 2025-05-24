import 'package:flutter/material.dart';

class AdicionarTarefa extends StatefulWidget {
  final void Function(String) onSave;

  const AdicionarTarefa({super.key, required this.onSave});

  @override
  State<AdicionarTarefa> createState() => _AdicionarTarefaState();
}

class _AdicionarTarefaState extends State<AdicionarTarefa> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    _controller.addListener(() {
      setState(() {
        _isValid = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Adicionar tarefa",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            TextField(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: "Nova tarefa",
                hintText: "Ex: Comprar leite",
                filled: true,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: _isValid
                    ? () {
                        widget.onSave(_controller.text.trim());
                        Navigator.of(context).pop();
                      }
                    : null,
                icon: const Icon(Icons.save),
                label: const Text("Salvar"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
