// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:ui';

import 'package:copon_app/shared/components/constants.dart';
import 'package:flutter/material.dart';

class RoundTextFormField extends StatelessWidget {
  final String? labelText;
  final String?  hintText;
  final String? changeValue;
  final String? Function(String?)? validator;
  final int? maxlines;
  TextInputType type;
  IconData prefixIcon;
  IconData? suffixIcon;
  bool obscureText ; 
  TextEditingController controller;
  VoidCallback? suffixOnclick;
  RoundTextFormField({
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.type,
    required this.controller,
    required this.obscureText,
    this.suffixIcon,
    this.suffixOnclick,
    this.changeValue, 
    this.validator, 
    this.maxlines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kPadding),
      child: TextFormField(
          keyboardType: type,
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          maxLines: maxlines,
          decoration: InputDecoration(
            border:OutlineInputBorder(),
            labelText: labelText,
            hintText: hintText,
            prefixIcon: Icon(prefixIcon),
            suffixIcon:IconButton(
                onPressed: (){
                  suffixOnclick!();
                },
                icon: Icon(suffixIcon),
              ),
              filled: true,
              focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kborderRadius),
              borderSide: BorderSide(color: Colors.blue)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kborderRadius),
                borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(kborderRadius),
                borderSide: BorderSide(color: Colors.red)),
              ) 
              ),
    );
  
}
}