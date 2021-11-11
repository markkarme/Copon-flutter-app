// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CardDesign extends StatelessWidget {
 IconData? icon;
 String? text;
 MaterialColor color;
 Function()?onTap;
 CardDesign({required this.icon,required this.text,required this.color,required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(20.0),
      child: InkWell(
        onTap: onTap,
        splashColor: color,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 70,color: color,),
              Text(
                text.toString(),
                style: TextStyle(fontSize: 17),
              )
            ],
          ),
        ),
      ),
    );
  }
}
