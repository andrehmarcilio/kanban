import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class KanBanDatabase {
  static const String _kanbanBoxKey = 'my_kanban_box';

  static Future<Box<Map>> initDataBase() async {
    Directory directory =
        await path_provider.getApplicationDocumentsDirectory();

    Hive.init(directory.path);
    return await Hive.openBox<Map>(_kanbanBoxKey);
  }
}
