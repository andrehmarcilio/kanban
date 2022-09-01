import 'package:kanban_app/domain/entity/kanban.dart';

import '../../domain/irepository/kanban_irepository.dart';
import '../local/dao/kanban_dao.dart';

class Repository extends IRepository {
  Repository(this._kanbanDao);
  final KanbanDao _kanbanDao;

  @override
  Future<void> createKanban(KanBan kanban) async {
   await _kanbanDao.createKanBan(kanban);
   return;
  }

  @override
  List<KanBan> getKanbans() {
   return  _kanbanDao.getKanban();
  }

  @override
  Future<void> updateKanban(KanBan kanban) async {
   await _kanbanDao.updateKanBan(kanban);
   return;
  }
}
