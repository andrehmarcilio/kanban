import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:uuid/uuid.dart';

import '../../domain/entity/todo.dart';
import '../bloc/kanban_bloc.dart';
import 'widget/custom_text_fiel.dart';

const uuid = Uuid();

class TodoForm extends StatefulWidget {
  const TodoForm({Key? key, required this.kanbanId}) : super(key: key);
  final String kanbanId;

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _tituloController = TextEditingController();
  String? tituloError;
  
  Cor selectedColor = Cor.blue;

  @override
  Widget build(BuildContext context) {
    final kanbanBloc = context.read<KanbanBloc>();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar nova Tarefa"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  labelText: "Título",
                  controller: _tituloController,
                  error: tituloError,
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 90.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: Cor.values.length,
                      itemBuilder: (context, position) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedColor = Cor.values[position];
                            });
                          },
                          child: Container(
                              width: size.width / 7,
                              height: size.width / 7,
                              margin: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Cor.values[position].cor,
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: selectedColor ==  Cor.values[position] ? 
                              const Icon(Icons.check, color: Colors.white,) : const SizedBox.shrink(),
                              ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancelar"))),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              if (_validarCampos()) {
                                final ToDo todo = _createTodo();
                                kanbanBloc.add(CreateTodo(todo));
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text("Salvar")))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validarCampos() {
    setState(() {
      tituloError = _tituloController.validar();
    });
    return tituloError == null;
  }

  ToDo _createTodo() {
    return ToDo(
      todoId: uuid.v1(), 
      titulo: _tituloController.text, 
      completo: false, 
      estagio: 0, 
      kanbanId: widget.kanbanId, 
      color: selectedColor);
  }
}

extension ValidarTextField on TextEditingController {
  String? validar() {
    if (text.isEmpty) {
      return "Digite um valor";
    }
    return null;
  }
}
