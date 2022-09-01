import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/kanban_bloc.dart';
import 'widget/kanban_board.dart';
import 'widget/kanban_lateral_menu.dart';


class KanbanPage extends StatelessWidget {
  const KanbanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<KanbanBloc>();
    return Scaffold(
      body: BlocBuilder<KanbanBloc, KanbanState>(
        bloc: bloc,
        builder: (context, state) => Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            KanbanLateralMenu(
              state: state
            ),
            KanbanBoard(
              state: state,
            )
          ],
        ),
      ),
    );
  }
}
