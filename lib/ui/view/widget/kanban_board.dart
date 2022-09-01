import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/domain/entity/kanban.dart';

import '../../bloc/kanban_bloc.dart';
import '../todo_form.dart';
import 'post_it_card.dart';

class KanbanBoard extends StatelessWidget {
  const KanbanBoard({Key? key, required this.state}) : super(key: key);
  final KanbanState state;

  @override
  Widget build(BuildContext context) {
    final kanbanBloc = context.read<KanbanBloc>();
    final kanban = state.selectedKanban;
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width - 80,
      child: Padding(
        padding: EdgeInsets.zero,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: SafeArea(
                    bottom: false,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Text(
                        kanban.titulo,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Divider(),
              const SizedBox(
                height: 32.0,
              ),
              ExpansionPanelList(
                animationDuration: const Duration(milliseconds: 500),
                expansionCallback: (panelIndex, isExpanded) {
                  kanbanBloc.add(ExpandKanbanPanel(panelIndex));
                },
                elevation: 0.0,
                children: List<ExpansionPanel>.generate(kanban.numeroDeEstagios,
                    (index) {
                  final todos = kanban.todos
                      .where((todo) => todo.estagio == index)
                      .toList();
                  return ExpansionPanel(
                      canTapOnHeader: true,
                      backgroundColor: Colors.transparent,
                      isExpanded: state.isExpandedList[index],
                      headerBuilder: (context, isExpanded) => Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                kanban.nomeDosEstagios[index],
                                maxLines: 1,
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                      body: todos.isNotEmpty || index == 0
                          ? ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  index != 0 ? todos.length : todos.length + 1,
                              itemBuilder: (context, position) {
                                if (index == 0 && position == todos.length) {
                                  return AddTodoButton(kanban: kanban);
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0),
                                  child: Dismissible(
                                    direction: _chooseDirection(
                                        index, kanban.numeroDeEstagios),
                                    onDismissed: (DismissDirection direction) {
                                      final bool foward = direction ==
                                          DismissDirection.startToEnd;
                                      kanbanBloc.add(OnDismissedToDo(
                                          todos[position], foward));
                                    },
                                    key: UniqueKey(),
                                    child: GestureDetector(
                                      onLongPress: () {
                                        _showDeleteDialog(context, () {
                                            kanbanBloc.add(OnDeleteToDo(todos[position]));
                                        });
                                      },
                                      child: PostItCard(
                                        todo: todos[position],
                                      ),
                                    ),
                                  ),
                                );
                              })
                          : const SizedBox.shrink());
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Function onDelete) {
    showDialog(
        context: context,
        builder: (alertDialogContext) => AlertDialog(
              title: const Text("Atenção"),
              content: Text(
                "Deseja deletar este item?",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(alertDialogContext);
                    },
                    child: const Text("cancelar")),
                TextButton(
                    onPressed: () {
                      onDelete();
                      Navigator.pop(alertDialogContext);
                    },
                    child: const Text("confirmar")),
              ],
            ));
  }

  _chooseDirection(int index, int numeroDeEstagios) {
    return index == 0
        ? DismissDirection.startToEnd
        : index < numeroDeEstagios - 1
            ? DismissDirection.horizontal
            : DismissDirection.endToStart;
  }
}

class AddTodoButton extends StatelessWidget {
  const AddTodoButton({
    Key? key,
    required this.kanban,
  }) : super(key: key);

  final KanBan kanban;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10.0, right: 16.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(9.0)),
              shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.5)))),
            ),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => TodoForm(
                      kanbanId: kanban.kanbanId,
                    ))),
            child: const Icon(Icons.add),
          ),
        ));
  }
}
