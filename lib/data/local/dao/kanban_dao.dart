import 'package:hive/hive.dart';

import '../../../domain/entity/kanban.dart';

class KanbanDao {
  final Box<Map> _hive;
  KanbanDao(this._hive);

  static const String _kanbanKey = 'my_kanban';

  List<KanBan> getKanban() {
    final List<KanBan> kanbans = [];
    final kanbansMap = _hive.get(_kanbanKey);
    if (kanbansMap != null) {
      kanbansMap.forEach((_, value) {
       value[todosColumn] = _removeDesativados(value[todosColumn]);

        if (!value[desativadoColumn]) {
          kanbans.add(KanBan.fromMap(value));
        }
      });
      return kanbans;
    } else {
      final simpleKanban = KanBan.simpleKanban();
      _createFirstKanBan(simpleKanban);
      return [simpleKanban];
    }
  }

  List _removeDesativados(todos) {
    List lista = [];
    lista.addAll(todos);
    
    for (int i = 0; i < lista.length; i++) {
      if (lista[i]["desativado"]) {
        lista.removeAt(i);
        i--;
      }
    }
    
   return lista;
  }

  Future<void> updateKanBan(KanBan kanban) async {
    final List<KanBan> kanbans = getKanban();
    final Map kanbansMap = {};
    int index =
        kanbans.indexWhere((element) => element.kanbanId == kanban.kanbanId);
    kanbans.removeAt(index);
    kanbans.insert(index, kanban);

    for (var element in kanbans) {
      kanbansMap.addAll(element.toMap());
    }
    await _hive.put(_kanbanKey, kanbansMap);
    return;
  }

 

  Future<void> createKanBan(KanBan kanban) async {
    final List<KanBan> kanbans = getKanban();
    final Map kanbansMap = {};
    kanbans.add(kanban);

    for (var element in kanbans) {
      kanbansMap.addAll(element.toMap());
    }
    await _hive.put(_kanbanKey, kanbansMap);
  }

  Future<void> _createFirstKanBan(KanBan kanban) async {
    await _hive.put(_kanbanKey, kanban.toMap());
  }
}
