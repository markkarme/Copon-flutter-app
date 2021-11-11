// ignore_for_file: prefer_const_constructors

import 'package:copon_app/modules/home_screen/widget/home_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      body: HomeBody(),
    );
  }
}