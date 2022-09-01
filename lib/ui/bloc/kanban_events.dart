part of 'kanban_bloc.dart';

abstract class KanbanEvents {}

class ChangeSelectedKanban extends KanbanEvents {
  KanBan selectedKanban;
  ChangeSelectedKanban(this.selectedKanban);
}

class ExpandKanbanPanel extends KanbanEvents {
  int panelIndex;
  ExpandKanbanPanel(this.panelIndex);
}

class OnDismissedToDo extends KanbanEvents {
  ToDo todoDismissed;
  bool foward;
  OnDismissedToDo(this.todoDismissed, this.foward);
}

class OnDeleteToDo extends KanbanEvents {
  ToDo todoDeleted;
  OnDeleteToDo(this.todoDeleted);
}

class CreateKanban extends KanbanEvents {
  KanBan newKanban;
  CreateKanban(this.newKanban);
}

class CreateTodo extends KanbanEvents {
  ToDo newTodo;
  CreateTodo(this.newTodo);
}

