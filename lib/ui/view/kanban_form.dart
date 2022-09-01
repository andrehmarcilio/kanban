import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';



import '../../domain/entity/kanban.dart';
import '../bloc/kanban_bloc.dart';
import 'widget/custom_text_fiel.dart';


const uuid = Uuid();

class KanbanForm extends StatefulWidget {
  const KanbanForm({Key? key}) : super(key: key);

  @override
  State<KanbanForm> createState() => _KanbanFormState();
}

class _KanbanFormState extends State<KanbanForm> {
  final _tituloController = TextEditingController();
  final _etapaFinalController = TextEditingController();
  String? tituloError;
  String? etapaFinalError;

  final List<String?> errorsTexts = [null];
  final List<TextEditingController> controllersEstagios = [
    TextEditingController()
  ];

  @override
  Widget build(BuildContext context) {
    final kanbanBloc = context.read<KanbanBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar novo Quadro"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: double.infinity,
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  labelText: "Título",
                  controller: _tituloController,
                  error: tituloError,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  labelText: "Etapa Inicial (To Do)",
                  controller: controllersEstagios[0],
                  error: errorsTexts[0],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: controllersEstagios.length,
                    itemBuilder: (context, position) {
                      if (position == controllersEstagios.length - 1) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: OutlinedButton(
                            onPressed: () => _adicionarNovaEtapa(),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(9.0)),
                              shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.5)))),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Nova etapa"),
                              ],
                            ),
                          ),
                        );
                      }
                      return CustomTextField(
                        labelText: "Etapa ${position + 2}",
                        controller: controllersEstagios[position + 1],
                        error: errorsTexts[position + 1],
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => _removerItem(position + 1),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  labelText: "Etapa Final (Done)",
                  controller: _etapaFinalController,
                  error: errorsTexts[0],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancelar"))),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: ()  {

                              if (_validarCampos()) {
                       
                                final KanBan kanban = _createKanban();
                                 kanbanBloc.add(CreateKanban(kanban));
                                 Navigator.of(context).pop();
                              }
                            },
                            child: const Text("Salvar")))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _validarCampos() {
    setState(() {
      tituloError = _tituloController.validar();
      etapaFinalError = _etapaFinalController.validar();
      for (int i = 0; i < errorsTexts.length; i++) {
        errorsTexts[i] = controllersEstagios[i].validar();
      }
    });
    return errorsTexts.every((erro) => erro == null) &&
        tituloError == null &&
        etapaFinalError == null;
  }

  _adicionarNovaEtapa() {
    setState(() {
      errorsTexts.add(null);
      controllersEstagios.add(TextEditingController());
    });
  }

  _removerItem(int position) {
    setState(() {
      errorsTexts.removeAt(position);
      controllersEstagios.removeAt(position);
    });
  }
  
  KanBan _createKanban() {
    final List<String> nomeDosEstagios = controllersEstagios.map((e) => e.text).toList();
    nomeDosEstagios.add(_etapaFinalController.text);
    return KanBan(
      kanbanId: uuid.v1(),
      titulo: _tituloController.text, 
      nomeDosEstagios: nomeDosEstagios, 
      numeroDeEstagios: controllersEstagios.length + 1, 
      wipPorEstagio: [], 
      todos: []);
  }
}

extension ValidarTextField on TextEditingController {
  String? validar() {
    if (text.isEmpty) {
      return "Digite um valor";
    }
    return null;
  }
}
