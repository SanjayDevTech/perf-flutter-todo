import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_test/data/app_database.dart';
import 'package:todo_test/ui/components/todo_item.dart';

import '../../main.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppDatabase database = AppDatabaseProvider.of(context).appDatabase;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo Test App"),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: database.todoDao.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Placeholder();
            } else {
              if (snapshot.data?.isEmpty ?? true) {
                return const Center(
                  child: Text(
                    'No records available',
                  ),
                );
              } else {
                final data = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemBuilder: (_, i) {
                      final todo = data[i];
                      return TodoItem(todo: todo, onClick: () {
                        context.push("/details/${todo.id}");
                      }, onDelete: () {
                        database.todoDao.delete(todo.id!);
                      });
                    },
                    itemCount: data.length,
                  ),
                );
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push("/details/0");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
