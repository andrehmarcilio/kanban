import 'package:flutter/material.dart';

const String todoTable = 'todo';
const String todoIdColumn = 'todoId';
const String tituloColumn = 'titulo';
const String completoColumn = 'completo';
const String estagioColumn = 'estagio';
const String kanbanIdColumn = 'kanbanId';
const String colorColumn = 'color';
const String sincronizadoColumn = 'sincronizado';
const String desativadoColumn = 'desativado';


class ToDo {
  String todoId;
  String titulo;
  bool completo;
  int estagio;
  String kanbanId;
  Cor color;
  bool sincronizado;
  bool desativado;

  Color get materialColor => color.cor;

  ToDo(
      {required this.todoId,
      required this.titulo,
      required this.completo,
      required this.estagio,
      required this.kanbanId,
      required this.color,
      this.sincronizado = false,
      this.desativado = false});

  ToDo.fromMap(Map map)
      : todoId = map[todoIdColumn],
        titulo = map[tituloColumn],
        completo = map[completoColumn] == 1,
        estagio = map[estagioColumn],
        kanbanId = map[kanbanIdColumn],
        color = (map[colorColumn] as String).transformarEmCor(),
        sincronizado = map[sincronizadoColumn],
        desativado = map[desativadoColumn];

  Map toMap() {
    final Map data = {};
    data[todoIdColumn] = todoId;
    data[tituloColumn] = titulo;
    data[completoColumn] = completo ? 1 : 0;
    data[estagioColumn] = estagio;
    data[kanbanIdColumn] = kanbanId;
    data[colorColumn] = color.value;
    data[sincronizadoColumn] = sincronizado;
    data[desativadoColumn] = desativado;
    return data;
  }

  static List<ToDo> fromMapList(List todosMap) {
    return todosMap.map((map) => ToDo.fromMap(map)).toList();
  }
}



enum Cor {
  blue("blue", Color.fromARGB(255, 21, 101, 192)),
  red("red", Color.fromARGB(255, 198, 40, 40)),
  yellow("yellow", Color.fromARGB(255, 249, 168, 37)),
  green("green", Color.fromARGB(255, 46, 125, 50)),
  pink("pink", Color.fromARGB(255, 173, 20, 87));

  final String value;
  final Color cor;
  
  const Cor(this.value, this.cor);
}

extension TrasformInCor on String {
  Cor transformarEmCor() {
    switch (this) {
      case "blue":
        return Cor.blue;
      case "red":
        return Cor.red;
      case "yellow":
        return Cor.yellow;
      case "green":
        return Cor.green;
      case "pink":
        return Cor.pink;
    }
    return Cor.blue;
  }
}
