// ignore_for_file: prefer_const_constructors

import 'package:copon_app/modules/choice_screen/widget/choice_body.dart';
import 'package:flutter/material.dart';

class ChoiceScreen extends StatelessWidget {
 String? text;
 ChoiceScreen({required this.text});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChoiceBody(text: text,),
    );
  }
}