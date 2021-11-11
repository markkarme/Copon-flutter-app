// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable, avoid_print
import 'package:copon_app/shared/components/constants.dart';
import 'package:copon_app/shared/components/round_button.dart';
import 'package:copon_app/shared/components/round_form_field.dart';
import 'package:copon_app/shared/components/size_config.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignForm extends StatelessWidget {
  var useremailController = TextEditingController();
  var userPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider.value(
        value: BlocProvider.of<CouponCubit>(context),
        child:BlocConsumer<CouponCubit,CouponStates>(
          builder: (context,state){
            var cubit = CouponCubit.getCubit(context);
                    return Form(
              key: _formKey,
              child: Column(
                children: [
                  RoundTextFormField(
                      labelText: "Email",
                      hintText: "Enter Your Email",
                      prefixIcon: FontAwesomeIcons.envelope,
                      type: TextInputType.emailAddress,
                      controller: useremailController,
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
                    obscureText: cubit.isPassword,
                    suffixIcon: cubit.isPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    suffixOnclick: () {
                      cubit.changePasswordShow();
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child:state is LoginLodingState?CircularProgressIndicator():
                     RoundButton(
                      text: "Sign In",
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.loginWithEmailAndPassword(
                              email: useremailController.text,
                              password: userPasswordController.text,
                              context: context);
                        } 
                      },
                    ),
                  ),
                ],
              ),
            );
          }, listener: (context,state){
          }) 
        );
  }
}
