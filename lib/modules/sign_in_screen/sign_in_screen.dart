// ignore_for_file: prefer_const_constructors

import 'package:copon_app/modules/sign_in_screen/widget/sign_in_body.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: SignInBody(),
    );
  }
}