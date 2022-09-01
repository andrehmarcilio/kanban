import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/kanban_bloc.dart';

import '../kanban_form.dart';
import 'lateral_cards.dart';

class KanbanLateralMenu extends StatelessWidget {
  const KanbanLateralMenu({Key? key, required this.state}) : super(key: key);
  final KanbanState state;

  @override
  Widget build(BuildContext context) {
    final kanbanBloc = context.read<KanbanBloc>();
    final kanbans = state.kanbans;
    final selectedKanban = state.selectedKanban;
    return Container(
      color: Theme.of(context).colorScheme.primary,
      width: 80,
      height: double.infinity,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 16.0, right: 12.0, bottom: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox.shrink(),
              ListView.builder(
                  itemCount: kanbans.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final kanban = kanbans[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14.0),
                      child: InkWell(
                        onTap: () {
                          kanbanBloc.add(ChangeSelectedKanban(kanban));
                        },
                        child: LateralCards(
                          letter: kanban.titulo[0].toUpperCase(),
                          size: 50.0,
                          selected: kanban.kanbanId == selectedKanban.kanbanId,
                        ),
                      ),
                    );
                  }),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.add_outlined,
                      size: 30,
                      color: Colors.grey.shade500,
                    ),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const KanbanForm())),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
