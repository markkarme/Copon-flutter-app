// ignore_for_file: prefer_const_constructors

import 'dart:ui';
import 'package:copon_app/shared/components/constants.dart';
import 'package:copon_app/shared/components/round_button.dart';
import 'package:copon_app/shared/components/round_form_field.dart';
import 'package:copon_app/shared/components/size_config.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddCouponBody extends StatelessWidget {
  var nameController = TextEditingController();
  var descController = TextEditingController();
  var couponNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SizeConfig().init(context);
    return BlocProvider.value(
      value: BlocProvider.of<CouponCubit>(context),
      child: BlocConsumer<CouponCubit, CouponStates>(
          builder: (context, state) {
            var cubit = CouponCubit.getCubit(context);
            return SingleChildScrollView(
                child: Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                        cubit.addCouponfile=null;
                      },
                    ),
                    SizedBox(
                      width: size.width * 0.2,
                    ),
                    Text(
                      "ADD Coupon",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  cubit.getImage(ImageSource.gallery);
                },
                child: Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400]!.withOpacity(
                              0.4,
                            ),
                            child: cubit.addCouponfile == null
                                ? Icon(
                                    FontAwesomeIcons.user,
                                    color: Colors.greenAccent,
                                    size: size.width * 0.1,
                                  )
                                : Image.file(cubit.addCouponfile!),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    RoundTextFormField(
                        labelText: "company name",
                        hintText: "enter company name",
                        prefixIcon: FontAwesomeIcons.building,
                        type: TextInputType.name,
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return kNameNullError;
                          }
                          return null;
                        },
                        obscureText: false),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    RoundTextFormField(
                        labelText: "company description",
                        hintText: "enter company Desc",
                        prefixIcon: FontAwesomeIcons.audioDescription,
                        type: TextInputType.text,
                        controller: descController,
                        maxlines: 5,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return kDescNullError;
                          }
                          return null;
                        },
                        obscureText: false),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    RoundTextFormField(
                        labelText: "coupon number",
                        hintText: "enter coupon number",
                        prefixIcon: FontAwesomeIcons.codepen,
                        type: TextInputType.text,
                        controller: couponNumberController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return kCouponNumberNullError;
                          }
                          return null;
                        },
                        obscureText: false),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: state is AddCouponState?CircularProgressIndicator():
                       RoundButton(
                        text: "Add Coupon",
                        press: () {
                          if (_formKey.currentState!.validate() &&
                              cubit.addCouponfile != null) {
                            cubit.storeCouponItems(
                                companyname: nameController.text,
                                description: descController.text,
                                couponcode: couponNumberController.text,
                                context: context
                                );
                          } else if (cubit.addCouponfile == null) {
                            Fluttertoast.showToast(
                              msg: "You must choose logo Image",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                            );
                          } else {}
                        },
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    )
                  ],
                ),
              )
            ]));
          },
          listener: (context, state) {}),
    );
  }
}
