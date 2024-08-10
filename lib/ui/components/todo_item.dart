import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../data/todo_entity.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key,
      required this.todo,
      required this.onClick,
      required this.onDelete});

  final TodoEntity todo;
  final VoidCallback onDelete;
  final VoidCallback onClick;

  void copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: todo.content));
    Fluttertoast.showToast(
        msg: "Copied to Clipboard 📋", toastLength: Toast.LENGTH_SHORT);
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        onTap: () async {
          // await Future.delayed(const Duration(milliseconds: 250));
          onClick();
        },
        onLongPress: copyToClipboard,
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                      height: double.infinity, child: Text(todo.content)),
                ),
              ),
              Flexible(
                flex: 2,
                child: IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
