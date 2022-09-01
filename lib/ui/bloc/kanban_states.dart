part of 'kanban_bloc.dart';



class KanbanState {
  List<KanBan> kanbans;
  KanBan selectedKanban;
  List<bool> isExpandedList;

  KanbanState(
      {required this.kanbans,
      required this.selectedKanban,
      required this.isExpandedList});
}