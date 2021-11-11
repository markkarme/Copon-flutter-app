import 'package:bloc/bloc.dart';
import 'package:copon_app/modules/welcome_screen.dart/welcome_screen.dart';
import 'package:copon_app/shared/bloc_observer.dart';
import 'package:copon_app/shared/components/theme.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>CouponCubit())
      ],
      child: MaterialApp(
        title: 'Copon App',
        theme:theme(),
        home:
        const WelcomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
