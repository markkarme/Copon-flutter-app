// ignore_for_file: prefer_const_constructors
import 'package:copon_app/modules/add_coupon/widget/add_coupon_body.dart';
import 'package:flutter/material.dart';

class AddCouponScreen extends StatelessWidget {
  const AddCouponScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AddCouponBody(),);
  }
}