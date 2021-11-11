// ignore_for_file: prefer_const_constructors
import 'package:copon_app/modules/sign_up_screen/widget/sign_up_form.dart';
import 'package:copon_app/shared/components/constants.dart';
import 'package:copon_app/shared/components/size_config.dart';
import 'package:flutter/material.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      SizeConfig().init(context);
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
                          Navigator.pop(context);
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
                "Sign Up",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kTextColor),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.02),
              Text(
                "Register Account",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: getProportionateScreenWidth(28),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.02),
              Text(
                "Complete your details or countinue\n with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SizeConfig.screenHeight! * 0.04),
              SignUpForm(),
            ],
          ),
        ),
      ),
    );
  }
}