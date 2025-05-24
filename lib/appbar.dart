import 'package:flutter/material.dart';

class AppBarApp extends StatelessWidget implements PreferredSizeWidget {
  const AppBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Minhas tarefas'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}