import 'todo.dart';

const String kanbanTable = 'kanban';
const String kanbanIdColumn = 'kanbanId';
const String tituloColumn = 'titulo';
const String numeroDeEstagiosColumn = 'numeroDeEstagios';
const String nomeDosEstagiosColumn = 'nomeDosEstagios';
const String wipPorEstagioColumn = 'wipPorEstagio';
const String todosColumn = 'todos';
const String sincronizadoColumn = 'sincronizado';
const String desativadoColumn = 'desativado';


class KanBan {
  String kanbanId;
  String titulo;
  int numeroDeEstagios;
  List<String> nomeDosEstagios;
  List<int> wipPorEstagio;
  List<ToDo> todos;
  bool sincronizado;
  bool desativado;

  KanBan(
      {required this.kanbanId,
      required this.titulo,
      required this.nomeDosEstagios,
      required this.numeroDeEstagios,
      required this.wipPorEstagio,
      required this.todos,
      this.sincronizado = false,
      this.desativado = false});

  KanBan.fromMap(Map map)
      : kanbanId = map[kanbanIdColumn],
        titulo = map[tituloColumn],
        numeroDeEstagios = map[numeroDeEstagiosColumn],
        nomeDosEstagios =map[nomeDosEstagiosColumn],
        wipPorEstagio = map[wipPorEstagioColumn],
        todos = ToDo.fromMapList(
            map[todosColumn]),
        sincronizado = map[sincronizadoColumn],
        desativado = map[desativadoColumn];

  Map toMap() {
    Map data = {};
    data[kanbanIdColumn] = kanbanId;
    data[tituloColumn] = titulo;
    data[numeroDeEstagiosColumn] = numeroDeEstagios;
    data[nomeDosEstagiosColumn] = nomeDosEstagios;
    data[wipPorEstagioColumn] = wipPorEstagio;
    data[todosColumn] = todos.map((e) => e.toMap()).toList();
    data[sincronizadoColumn] = sincronizado;
    data[desativadoColumn] = desativado;
    return {kanbanId : data};
  }

  KanBan.simpleKanban()
      : kanbanId = 'kanban',
        titulo = 'Kanban',
        numeroDeEstagios = 3,
        nomeDosEstagios = ['To Do', 'Doing', 'Done'],
        wipPorEstagio = [5, 5, 5],
        todos = [],
        sincronizado = false,
        desativado = false;
}
