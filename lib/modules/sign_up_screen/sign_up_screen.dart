// ignore_for_file: prefer_const_constructors

import 'package:copon_app/modules/sign_up_screen/widget/sign_up_body.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpBody(),
      
    );
  }
}