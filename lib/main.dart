import 'package:flutter/material.dart';

import 'data/local/kanban_database.dart';
import 'ui/kanban_container.dart';


void  main(List<String> args) async {
    WidgetsFlutterBinding.ensureInitialized();
    final hiverBox  = await KanBanDatabase.initDataBase();
    runApp(KanbanContainer(hiverBox));
}

