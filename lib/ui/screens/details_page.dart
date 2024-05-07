import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_test/data/app_database.dart';
import 'package:todo_test/data/todo_entity.dart';

import '../../main.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final isEditMode = id > 0;
    final AppDatabase database = AppDatabaseProvider.of(context).appDatabase;
    final todoStream = database.todoDao.get(id);
    return StreamBuilder(
      stream: todoStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final todo = snapshot.data;
        return _DetailPageContent(
          todo: todo,
          isEditMode: isEditMode,
        );
      },
    );
  }
}

class _DetailPageContent extends StatefulWidget {
  const _DetailPageContent({required this.todo, required this.isEditMode});

  final TodoEntity? todo;
  final bool isEditMode;

  @override
  State<_DetailPageContent> createState() => _DetailPageContentState();
}

class _DetailPageContentState extends State<_DetailPageContent> {
  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    myController.text = widget.todo?.content ?? "";
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppDatabase database = AppDatabaseProvider.of(context).appDatabase;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final content = myController.text;
          if (content.trim().isEmpty) return;
          if (widget.isEditMode) {
            if (widget.todo == null) return;
            await database.todoDao
                .update(widget.todo!.copyWith(content: myController.text));
          } else {
            await database.todoDao.insert(TodoEntity(null, content));
          }
          if (!context.mounted) return;
          context.pop();
        },
        child: const Icon(Icons.check),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: SizedBox(
            height: double.infinity,
            child: TextField(
              controller: myController,
              expands: true,
              
              maxLines: null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
                isCollapsed: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
