import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/irepository/kanban_irepository.dart';
import '../../domain/entity/kanban.dart';
import '../../domain/entity/todo.dart';

part 'kanban_states.dart';
part 'kanban_events.dart';

class KanbanBloc extends Bloc<KanbanEvents, KanbanState> {
  IRepository repository;
  KanbanBloc(this.repository)
      : super(KanbanState(
            kanbans: repository.getKanbans(),
            selectedKanban: repository.getKanbans().first,
            isExpandedList: getExpandedList(
                repository.getKanbans().first.numeroDeEstagios))) {
    on<ChangeSelectedKanban>(_changeSelectedKanban);
    on<ExpandKanbanPanel>(_expandKanbanPanel);
    on<OnDismissedToDo>(_onDismissedToDo);
    on<CreateKanban>(_createKanban);
    on<CreateTodo>(_createTodo);
    on<OnDeleteToDo>(_deleteTodo);
  }

  _changeSelectedKanban(ChangeSelectedKanban event, Emitter emit) {
    emit(KanbanState(
        kanbans: state.kanbans,
        selectedKanban: event.selectedKanban,
        isExpandedList:
            getExpandedList(event.selectedKanban.numeroDeEstagios)));
  }

  _expandKanbanPanel(ExpandKanbanPanel event, Emitter emit) {
    List<bool> isExpandedList = state.isExpandedList;
    isExpandedList[event.panelIndex] = !isExpandedList[event.panelIndex];
    emit(KanbanState(
        kanbans: state.kanbans,
        selectedKanban: state.selectedKanban,
        isExpandedList: isExpandedList));
  }

  _onDismissedToDo(OnDismissedToDo event, Emitter emit) async {
    final kanban = state.selectedKanban;
    final index = kanban.todos
        .indexWhere((todo) => todo.todoId == event.todoDismissed.todoId);
    final operador = event.foward ? 1 : -1;
    state.isExpandedList[kanban.todos[index].estagio + operador] = true;
    kanban.todos[index].estagio += operador;

    emit(KanbanState(
        kanbans: state.kanbans,
        selectedKanban: kanban,
        isExpandedList: state.isExpandedList));

    await repository.updateKanban(kanban);
  }

  FutureOr<void> _createKanban(
      CreateKanban event, Emitter<KanbanState> emit) async {
    await repository.createKanban(event.newKanban);
    emit(KanbanState(
        kanbans: repository.getKanbans(),
        selectedKanban: state.selectedKanban,
        isExpandedList: state.isExpandedList));
    return;
  }

  FutureOr<void> _createTodo(
      CreateTodo event, Emitter<KanbanState> emit) async {
    final kanbanWithNewTodo = state.selectedKanban;
    kanbanWithNewTodo.todos.add(event.newTodo);
    await repository.updateKanban(kanbanWithNewTodo);
    emit(KanbanState(
        kanbans: repository.getKanbans(),
        selectedKanban: state.selectedKanban,
        isExpandedList: state.isExpandedList));
    return;
  }

  FutureOr<void> _deleteTodo(
      OnDeleteToDo event, Emitter<KanbanState> emit) async {
    final kanban = state.selectedKanban;
    event.todoDeleted.desativado = true;
    int index = kanban.todos
        .indexWhere((todo) => todo.todoId == event.todoDeleted.todoId);
    kanban.todos.removeAt(index);
    kanban.todos.insert(index, event.todoDeleted);
    await repository.updateKanban(kanban);
    kanban.todos.removeAt(index);
    emit(KanbanState(
        kanbans: repository.getKanbans(),
        selectedKanban: kanban,
        isExpandedList: state.isExpandedList));
  }
}

List<bool> getExpandedList(int length) =>
    List.generate(length, (index) => false);
