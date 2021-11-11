// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:copon_app/modules/edit_coupon/widget/edit_data_body.dart';
import 'package:flutter/material.dart';

class EditDataScreen extends StatelessWidget {
 String? code;
  EditDataScreen({ required this.code });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditDataBody(code:code),
    );
  }
}