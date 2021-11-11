// ignore_for_file: prefer_const_constructors

import 'package:copon_app/modules/show_coupon/widget/show_body.dart';
import 'package:flutter/material.dart';
class ShowCoupon extends StatelessWidget {
  const ShowCoupon({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         elevation: 0,
         title: Text("Show Data",style: TextStyle(color: Colors.black,fontSize: 20),),
         centerTitle: true,
         backgroundColor:Theme.of(context).scaffoldBackgroundColor,
         iconTheme:IconThemeData(
           color: Colors.black
         ) ,
       ),
       body: ShowCouponBody(),
    );
   
  }
}