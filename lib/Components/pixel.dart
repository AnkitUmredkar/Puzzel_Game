import 'package:flutter/material.dart';

class Pixel extends StatelessWidget{
  var color,child;
  Pixel({super.key,required this.color,required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(4)),
        margin: const EdgeInsets.all(1),
        child: const Center(
          child: Text(
            '',//child.toString(),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

}