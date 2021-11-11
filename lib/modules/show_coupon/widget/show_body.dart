// ignore_for_file: prefer_const_constructors

import 'package:copon_app/modules/show_coupon/widget/custom_card.dart';
import 'package:copon_app/shared/components/size_config.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowCouponBody extends StatelessWidget {
  const ShowCouponBody({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider.value(
      value: BlocProvider.of<CouponCubit>(context)..showCouponData(),
      child: BlocConsumer<CouponCubit,CouponStates>(
        builder: (context,state){
          var cubit = CouponCubit.getCubit(context);
          if(state is ShowCouponLoadingState||cubit.ShowcouponDataList.isEmpty){
            return Center(
              child:CircularProgressIndicator() ,
            );
          }else{
            return ListView.builder(
            itemCount:cubit.ShowcouponDataList.length,
            itemBuilder: (context,items){
             return CustomCard(
               couponItems: cubit.ShowcouponDataList[items],
             );
            });
          }
        }, 
        listener: (context,state){
        }
        ),
      );
  }
}