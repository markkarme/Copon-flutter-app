// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:copon_app/modules/add_coupon/add_coupon.dart';
import 'package:copon_app/modules/edit_coupon/show_edit_coupon_items.dart';
import 'package:copon_app/modules/home_screen/widget/card_design.dart';
import 'package:copon_app/modules/show_coupon/show_coupon.dart';
import 'package:copon_app/shared/components/components.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CouponCubit>(context)..getPersonData(),
      child: BlocConsumer<CouponCubit, CouponStates>(
        builder: (context, state) {
          var cubit = CouponCubit.getCubit(context);
          if(cubit.isAdmin){
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(80),
                child: Column(
                  children: [
                    Text(
                      "Welcome ${cubit.personName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      cubit.personEmail,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      cubit.checkisAdmin.toString(),
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    CardDesign(
                      icon: Icons.add,
                      text: 'ADD Data',
                      color: Colors.green,
                      onTap: (){
                        navigateTo(context, AddCouponScreen());
                      },
                    ),
                    CardDesign(
                      icon: Icons.select_all,
                      text: 'Show Data',
                      color: Colors.orange,
                      onTap: (){
                        print("Show Data");
                        navigateTo(context, ShowCoupon());                     
                      },
                    ),
                    CardDesign(
                      icon: Icons.edit,
                      text: 'Edit Data',
                      color: Colors.teal,
                      onTap: (){
                        print("Edit Data");
                        navigateTo(context, ShowEditCouponItems());
                      },
                    ),
                    CardDesign(
                      icon: Icons.logout,
                      text: 'Log Out',
                      color: Colors.red,
                      onTap:(){
                        print("Logout");
                        cubit.signOut(context);
                      } ,
                    ),
                  ],
                ),
              ),
            ],
          );  
          }else{
            return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(80),
                child: Column(
                  children: [
                    Text(
                      "Welcome ${cubit.personName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      cubit.personEmail,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      cubit.isAdmin.toString(),
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: [
                    CardDesign(
                      icon: Icons.select_all,
                      text: 'Show Data',
                      color: Colors.orange,
                      onTap: (){
                        print("Show Data");
                        navigateTo(context, ShowCoupon());                     
                      },
                    ),
                    CardDesign(
                      icon: Icons.logout,
                      text: 'Log Out',
                      color: Colors.red,
                      onTap:(){
                        print("Logout");
                        cubit.signOut(context);
                      } ,
                    ),
                  ],
                ),
              ),
            ],
          );
          }},
        listener: (context, state) {},
      ),
    );
  }
}
