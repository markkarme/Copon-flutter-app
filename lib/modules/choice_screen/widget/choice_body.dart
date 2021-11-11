// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:copon_app/modules/sign_in_screen/sign_in_screen.dart';
import 'package:copon_app/modules/sign_up_screen/sign_up_screen.dart';
import 'package:copon_app/modules/welcome_screen.dart/welcome_screen.dart';
import 'package:copon_app/shared/components/components.dart';
import 'package:copon_app/shared/components/constants.dart';
import 'package:copon_app/shared/components/size_config.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChoiceBody extends StatelessWidget {
  String? text;
  ChoiceBody({required this.text});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider.value(
        value: BlocProvider.of<CouponCubit>(context),
        child: BlocConsumer<CouponCubit, CouponStates>(
            builder: (context, state) {
              var cubit=CouponCubit.getCubit(context);
              return SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                  onPressed: () {
                                    navigateAndFinish(context, WelcomeScreen());
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  )),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.01),
                        Text(
                          "Welcome!",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.01),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Welcome to our application",
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: getProportionateScreenWidth(15),
                                  ),
                                ),
                                Text("where you can ${text} As User or Admin",
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontSize: getProportionateScreenWidth(15),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.08),
                        Center(
                            child: SvgPicture.asset(
                          "assets/icons/Teamwork.svg",
                          width: 220,
                          height: 220,
                        )),
                        SizedBox(height: SizeConfig.screenHeight! * 0.04),
                        Divider(),
                        SizedBox(height: SizeConfig.screenHeight! * 0.08),
                        Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orange),
                              ),
                              onPressed: () {
                                if (text == kLoginText) {
                                  Fluttertoast.showToast(msg: "User Login");
                                  cubit.isAdmin=false;
                                  print(cubit.isAdmin);
                                  navigateTo(context, SignInScreen());
                                } else {
                                  Fluttertoast.showToast(msg: "User Register");
                                  cubit.isAdmin=false;
                                  print(cubit.isAdmin);
                                  navigateTo(context, SignUpScreen());
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.user),
                                  Text(
                                    "\t\tUser",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  )
                                ],
                              )),
                        ),
                        SizedBox(height: SizeConfig.screenHeight! * 0.02),
                        Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.green),
                              ),
                              onPressed: () {
                                if (text == kLoginText) {
                                  Fluttertoast.showToast(msg: "Admin Login");
                                  cubit.isAdmin=true;
                                  print(cubit.isAdmin);
                                  navigateTo(context, SignInScreen());
                                } else {
                                  Fluttertoast.showToast(msg: "Admin Register");
                                  cubit.isAdmin=true;
                                  print(cubit.isAdmin);
                                  navigateTo(context, SignUpScreen());
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.mask),
                                  Text(
                                    "\t\tAdmin",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  )
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            listener: (context, state) {}));
  }
}
