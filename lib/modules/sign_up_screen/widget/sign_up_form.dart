// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, must_be_immutable

import 'package:copon_app/shared/components/constants.dart';
import 'package:copon_app/shared/components/round_button.dart';
import 'package:copon_app/shared/components/round_form_field.dart';
import 'package:copon_app/shared/components/size_config.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpForm extends StatelessWidget {
  var emailController = TextEditingController();
  var userPasswordController = TextEditingController();
  var userConfirmPasswordController = TextEditingController();
  var nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider.value(
      value: BlocProvider.of<CouponCubit>(context),
      child: BlocConsumer<CouponCubit, CouponStates>(
          builder: (context, state) {
            var cubit = CouponCubit.getCubit(context);
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  RoundTextFormField(
                      labelText: "Name",
                      hintText: "Enter Your Name",
                      prefixIcon: FontAwesomeIcons.user,
                      type: TextInputType.name,
                      controller: nameController,
                      maxlines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return kNameNullError;
                        }
                        return null;
                      },
                      obscureText: false),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  RoundTextFormField(
                      labelText: "Email",
                      hintText: "Enter Your Email",
                      prefixIcon: FontAwesomeIcons.envelope,
                      type: TextInputType.emailAddress,
                      controller: emailController,
                      maxlines: 1,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return kEmailNullError;
                        } else if (!emailValidatorRegExp.hasMatch(value)) {
                          return kInvalidEmailError;
                        }
                        return null;
                      },
                      obscureText: false),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  RoundTextFormField(
                    labelText: "Password",
                    hintText: "Enter Your Password",
                    prefixIcon: FontAwesomeIcons.lock,
                    type: TextInputType.visiblePassword,
                    controller: userPasswordController,
                    maxlines: 1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return kPassNullError;
                      } else if (value.length < 8) {
                        return kShortPassError;
                      }
                      return null;
                    },
                    obscureText: cubit.isSignupPassword,
                    suffixIcon: cubit.isSignupPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixOnclick: () {
                      cubit.changeSignupPasswordShow();
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  RoundTextFormField(
                    labelText: "Confirm Password",
                    hintText: "Enter Your Confirm Password",
                    prefixIcon: FontAwesomeIcons.lock,
                    type: TextInputType.visiblePassword,
                    maxlines: 1,
                    controller: userConfirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return kPassNullError;
                      } else if (value.length < 8) {
                        return kShortPassError;
                      }else if(value != userPasswordController.text){
                        return kMatchPassError;
                      }
                      return null;
                    },
                    obscureText: cubit.isConfirmPassword,
                    suffixIcon: cubit.isConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixOnclick: () {
                      cubit.changeConfirmPasswordShow();
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  
                  SizedBox(height: getProportionateScreenHeight(30)),
                  Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: state is SignupLoadingState
                        ? CircularProgressIndicator()
                        : RoundButton(
                            text: "Sign Up",
                            press: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                cubit.createEmail(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: userPasswordController.text,
                                    context: context);
                              } else {
                                //write Here Any thing
                              }
                            },
                          ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(5)),
                ],
              ),
            );
          },
          listener: (context, state) {}),
    );
  }
}
