// ignore_for_file: prefer_const_constructors

import 'package:copon_app/modules/edit_coupon/widget/custom_edit_card.dart';
import 'package:copon_app/modules/home_screen/home_screen.dart';
import 'package:copon_app/shared/components/components.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowEditBody extends StatelessWidget {
  const ShowEditBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CouponCubit>(context)..showCouponData(),
      child: BlocConsumer<CouponCubit, CouponStates>(
          builder: (contest, state) {
            var cubit = CouponCubit.getCubit(context);
            if (state is ShowCouponLoadingState ||
                cubit.ShowcouponDataList.isEmpty) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: cubit.ShowcouponDataList.length,
                  itemBuilder: (context, items) {
                    return CustomEditCard(
                      couponItems: cubit.ShowcouponDataList[items],
                    );
                  });
            }
          },
          listener: (contest, state) {}),
    );
  }
}
