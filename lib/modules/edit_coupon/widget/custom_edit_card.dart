// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:copon_app/models/coupon_items_model.dart';
import 'package:copon_app/modules/edit_coupon/widget/edit_data.dart';
import 'package:copon_app/shared/components/components.dart';
import 'package:copon_app/shared/components/constants.dart';
import 'package:copon_app/shared/components/size_config.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomEditCard extends StatelessWidget {
  CouponItems couponItems;
  CustomEditCard({required this.couponItems});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider.value(
      value: BlocProvider.of<CouponCubit>(context),
      child: BlocConsumer<CouponCubit, CouponStates>(
          builder: (context, state) {
            // var cubit = CouponCubit.getCubit(context);
            return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                height: 270,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () {
                          navigateTo(context, EditDataScreen(code:couponItems.couponcode));
                        }, icon: Icon(Icons.edit)),
                        Text(couponItems.companyname!,style: TextStyle(color: Colors.green,fontSize: 20),),

                        couponItems.logocompany == null
                            ? Image(
                                image: AssetImage("assets/images/no-image.png"),
                                width: 80,
                                height: 80,
                              )
                            : Image.network(
                                couponItems.logocompany!,
                                width: 80,
                                height: 80,
                              ),
                      ],
                    ),
                    SizedBox(
                      height: kPadding2,
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 0,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kPaddingCouponText),
                      child: Text(
                        couponItems.description.toString(),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 0.5,
                      height: 0,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(kPadding2),
                          child: Row(
                            children: [
                              //Icon(Icons.keyboard_arrow_down),
                              Text(" "),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: kPadding2,
                        ), 
                        Container(
                                  height: 40,
                                  width: SizeConfig.screenWidth!*0.60,
                                  decoration: BoxDecoration(
                                    color: kCodeNumberColor,
                                    borderRadius: BorderRadius.circular(
                                      5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      couponItems.couponcode!,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                      ],
                    )
                 );
          },
          listener: (context, state) {}),
    );
  }
}
