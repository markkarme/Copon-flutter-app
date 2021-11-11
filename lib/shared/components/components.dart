import 'package:flutter/material.dart';

void navigateAndFinish(context, widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false);
}

void navigateTo(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

// Toast({required text,required Color color,context})=>showToast(text,backgroundColor: color,position: StyledToastPosition.bottom,context: context);
