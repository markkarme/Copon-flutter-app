// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:copon_app/modules/edit_coupon/show_edit_coupon_items.dart';
import 'package:copon_app/shared/components/components.dart';
import 'package:copon_app/shared/components/constants.dart';
import 'package:copon_app/shared/components/round_form_field.dart';
import 'package:copon_app/shared/components/size_config.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class EditDataBody extends StatelessWidget {
  String? code;
  EditDataBody({required this.code});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;
    return BlocProvider.value(
      value: BlocProvider.of<CouponCubit>(context)..getOneCouponItem(code),
      child: BlocConsumer<CouponCubit, CouponStates>(
          builder: (context, state) {
            if (state is GetSpecialDataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              var cubit = CouponCubit.getCubit(context);
              var companyNameController =
                  TextEditingController(text: cubit.data!["companyname"]);
              var companyDescController =
                  TextEditingController(text: cubit.data!["description"]);
              var companyCodeController =
                  TextEditingController(text: cubit.codenumber);
              return Padding(
                padding: EdgeInsets.all(kPadding2),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              navigateAndFinish(context, ShowEditCouponItems());
                            },
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.settings,
                                color: Colors.black,
                              ))
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                "Edit Coupon Data",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            Divider(
                              color: Colors.black,
                              indent: 10,
                              endIndent: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Fluttertoast.showToast(
                                  msg: "Choose Image",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                );
                                cubit.getLogoImage(ImageSource.gallery);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Colors.transparent,
                                    width: 150,
                                    height: 100,
                                    child: Center(
                                      child: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        radius: 100,
                                        child: ClipOval(
                                          child: cubit.displayLogoImage(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            RoundTextFormField(
                                labelText: "Company Name",
                                hintText: "company name",
                                prefixIcon: FontAwesomeIcons.building,
                                type: TextInputType.text,
                                maxlines: 1,
                                controller: companyNameController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return kNameNullError;
                                  }
                                  return null;
                                },
                                obscureText: false),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            RoundTextFormField(
                                labelText: "Company Description",
                                hintText: "company desc",
                                prefixIcon: FontAwesomeIcons.audioDescription,
                                type: TextInputType.text,
                                maxlines: 5,
                                controller: companyDescController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return kDescNullError;
                                  }
                                  return null;
                                },
                                obscureText: false),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.02,
                            ),
                            RoundTextFormField(
                                labelText: "Company Code",
                                hintText: "company code",
                                prefixIcon: FontAwesomeIcons.codeBranch,
                                type: TextInputType.text,
                                maxlines: 1,
                                controller: companyCodeController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return kCouponNumberNullError;
                                  }
                                  return null;
                                },
                                obscureText: false),
                            SizedBox(
                              height: SizeConfig.screenHeight! * 0.04,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(kPadding2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  OutlineButton(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      onPressed: () {
                                        navigateTo(
                                            context, ShowEditCouponItems());
                                      },
                                      child: Text(
                                        "CANCEL",
                                        style: TextStyle(
                                            fontSize: 14,
                                            letterSpacing: 2.2,
                                            color: Colors.black),
                                      )),
                                  RaisedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate() &&
                                          cubit.companyimage != null) {
                                        if (companyNameController.text ==
                                                cubit.companyname &&
                                            companyDescController.text ==
                                                cubit.companydesc &&
                                            companyCodeController.text ==
                                                cubit.codenumber &&
                                            cubit.companyimage.toString() ==
                                                cubit.oldcompnayimage
                                                    .toString()) {
                                          print("Data Has Been Exist");
                                          Fluttertoast.showToast(
                                            msg: "This Data Has Been Existed",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                          );
                                        } else if (companyNameController.text ==
                                                cubit.companyname ||
                                            companyDescController.text ==
                                                cubit.companydesc ||
                                            cubit.companyimage.toString() ==
                                                cubit.oldcompnayimage
                                                    .toString()) {
                                          print("Some Data Are Changed");
                                          cubit.checkOnCouponCode(
                                            companyname:
                                                companyNameController.text,
                                            companydesc:
                                                companyDescController.text,
                                            cuponcode:
                                                companyCodeController.text,
                                          );
                                        } else {
                                          print("All Data Are Changed");
                                          cubit.checkOnCouponCode(
                                            companyname:
                                                companyNameController.text,
                                            companydesc:
                                                companyDescController.text,
                                            cuponcode:
                                                companyCodeController.text,
                                          );
                                        }
                                      } else if (cubit.companyimage == null) {
                                        Fluttertoast.showToast(
                                          msg: "You Must Choose Image",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                      }
                                    },
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    color: Colors.green,
                                    child: Text(
                                      "UPDATE",
                                      style: TextStyle(
                                          fontSize: 14,
                                          letterSpacing: 2.2,
                                          color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
          listener: (context, state) {}),
    );
  }
}
