import 'package:flutter/material.dart';

class LateralCards extends StatelessWidget {
  const LateralCards({Key? key, required this.letter, required this.size, required this.selected}) : super(key: key);
  final String letter;
  final bool selected;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: selected ? Theme.of(context).colorScheme.secondary : Colors.grey.shade600,
        borderRadius: BorderRadius.circular(5.5)
      ),
      
      child: Center(
        child: Text(letter, style: !selected ? Theme.of(context).textTheme.bodyLarge : const TextStyle(
        fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black),),
      ),
    );
  }
}
