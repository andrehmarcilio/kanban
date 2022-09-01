import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../data/local/dao/kanban_dao.dart';
import '../data/repository/kanban_repository.dart';
import '../domain/irepository/kanban_irepository.dart';
import 'bloc/kanban_bloc.dart';
import 'theme/app_theme.dart';
import 'view/kanban_page.dart';

class KanbanContainer extends StatelessWidget {
  const KanbanContainer(this._hive, {Key? key}) : super(key: key);
  final Box<Map> _hive;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => KanbanDao(_hive)),
        // ignore: unnecessary_cast
        Provider(create: (context) => Repository(context.read()) as IRepository),
        Provider(create: (context) => KanbanBloc(context.read()))
      ],
      child: MaterialApp(
        theme: appLightTheme,
        home: const KanbanPage(),
      ),
    );
  }
}
