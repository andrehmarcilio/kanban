import 'package:flutter/material.dart';

import '../../../domain/entity/todo.dart';


class PostItCard extends StatelessWidget {
  const PostItCard({Key? key, required this.todo}) : super(key: key);
  final ToDo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: todo.materialColor,
        borderRadius: BorderRadius.circular(5.5)
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.all(16.0),
      child: Text(todo.titulo),
    );
  }
}