// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use
import 'package:copon_app/modules/choice_screen/choice_screen.dart';
import 'package:copon_app/shared/components/components.dart';
import 'package:copon_app/shared/components/constants.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomeBody extends StatelessWidget {
  const WelcomeBody({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
      return BlocProvider.value(
        value: BlocProvider.of<CouponCubit>(context),
        child: BlocConsumer<CouponCubit,CouponStates>(
          builder: (context,state){
            return  Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/samuel-regan-asante.jpg"),
              fit: BoxFit.cover,
              colorFilter:
                  ColorFilter.mode(Colors.black54, BlendMode.luminosity)),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Welcome In Our App",style: TextStyle(color: Colors.white,fontSize: 36),),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(kPadding2),
              child: Text("Have a Nice Time Bro",style: TextStyle(color: Colors.white,fontSize: 15),),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Row(
          children: [
              Expanded(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36),
                ),
                color: kPrimaryColor,
                onPressed: () {
                navigateTo(context, ChoiceScreen(text: kRegisterText,));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 30,
            ),
          Expanded(
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                    side: BorderSide(color: kPrimaryColor)),
                onPressed: () { 
                navigateTo(context, ChoiceScreen(text: kLoginText,));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
          ), 
            ],
        ) ,
          );
          }, listener: (context,state){}) 
      );
  }
}