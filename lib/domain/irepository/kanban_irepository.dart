
import '../entity/kanban.dart';

abstract class IRepository {
  List<KanBan> getKanbans();
  Future<void> updateKanban(KanBan kanban);
  Future<void> createKanban(KanBan kanban);
}