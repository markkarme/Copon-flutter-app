import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kborderRadius =15.0;
const kCopyButtonColor=Color(0xFF03ad94);
const kCodeNumberColor=Color(0xFFeeeeee);
const kToastErrorColor=Color(0xFFD50000);
// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Confirm Passwords don't match Password";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String kNameNullError = "Please Enter your name";
const String kDescNullError = "Please Enter your desc";
const String kCouponNumberNullError = "Please Enter your Coupon Number";
const String kInvalidNameError = "Please Enter Valid Name";
const String kInvaliddescError = "Please Enter Valid Description";
const String kCollection="Coupons";
const String kadminCollection='Admins';
const String kuserCollection='Users';
const double kPadding =20;
const double kPadding2=8.0;
const double kPaddingCouponText=10;
const double kLeftPadding=5.0;
const double ktopPadding=20.0;
const double krightPadding=5.0;
const double kbottomPadding=20.0;
const double kborderRadius2=25;
const double kSize=40.0;

const String kLoginSuccessfully="Login Done Successfully";
const String kLoginFaild ="Login Faild";
const String kEmailNotFound="No User Found for that Email";
const String kPasswordNotProvidedforthatEmail= "Wrong Password Provided for that Email.";
const String kEmailExisted="This Email is Existed";
const String kRegisterText="Register";
const String kLoginText="Login";
