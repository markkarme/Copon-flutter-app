// ignore_for_file: avoid_print, unrelated_type_equality_checks, prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:copon_app/models/admin_model.dart';
import 'package:copon_app/models/coupon_items_model.dart';
import 'package:copon_app/models/user_model.dart';
import 'package:copon_app/modules/choice_screen/choice_screen.dart';
import 'package:copon_app/modules/home_screen/home_screen.dart';
import 'package:copon_app/shared/components/components.dart';
import 'package:copon_app/shared/components/constants.dart';
import 'package:copon_app/shared/coupon_cubit/coupon_states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

class CouponCubit extends Cubit<CouponStates> {
  CouponCubit() : super(InitialState());
  static CouponCubit getCubit(context) => BlocProvider.of(context);
  var isAdmin = false;
  bool isPassword = true;
  bool isSignupPassword = true;
  bool isConfirmPassword = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserModel? userModel;
  AdminModel? adminModel;
  UserCredential? userCredential;
  Map<String, dynamic>? persondata = {};
  var personName = '';
  var personEmail = '';
  var checkisAdmin;
  File? addCouponfile;
  final addCouponimagePicker = ImagePicker();
  CouponItems? couponItems;
  List<CouponItems> ShowcouponDataList = [];
  var codenumber;
  var companyimage;
  var companyname;
  var companydesc;
  var oldcompnayimage;
  Map<String, dynamic>? data = {};
  File? file;
  void changePasswordShow() {
    isPassword = !isPassword;
    emit(ChangePasswordState());
  }

  void changeSignupPasswordShow() {
    isSignupPassword = !isSignupPassword;
    emit(ChangeSignupPasswordState());
  }

  void changeConfirmPasswordShow() {
    isConfirmPassword = !isConfirmPassword;
    emit(ChangeConfirmPasswordState());
  }

  void loginWithEmailAndPassword(
      {required email, required password, context}) async {
    emit(LoginLodingState());
    Future.delayed(const Duration(seconds: 5));
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential!.user!.uid);
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        emit(LogInSuccessState());
        Fluttertoast.showToast(
          msg: kLoginSuccessfully,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        navigateTo(context, const HomeScreen());
      }).catchError((e) {
        emit(LogInErrorState());
        Fluttertoast.showToast(
            msg: kLoginFaild,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: kToastErrorColor);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(EmailErrorState());
        Fluttertoast.showToast(
            msg: kEmailNotFound,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: kToastErrorColor);
      } else if (e.code == 'wrong-password') {
        emit(PasswordErrorState());
        Fluttertoast.showToast(
            msg: kPasswordNotProvidedforthatEmail,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: kToastErrorColor);
      }
    }
  }

  void createEmail({
    required name,
    required email,
    required password,
    required context,
  }) async {
    emit(SignupLoadingState());
    Future.delayed(const Duration(seconds: 5));
    final list = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (list.isNotEmpty) {
      Fluttertoast.showToast(
          msg: kEmailExisted,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: kToastErrorColor,
          textColor: Colors.white);
      emit(EmailExistSate());
    } else {
      auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (isAdmin) {
          adminModel = AdminModel(
              email: value.user!.email, name: name, uid: value.user!.uid);
          FirebaseFirestore.instance
              .collection(kadminCollection)
              .doc(value.user!.uid)
              .set(adminModel!.toMap())
              .then((value) {
            emit(SaveAdminDataSuccessState());
            Fluttertoast.showToast(
              msg: "Done Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          }).catchError((e) {
            emit(SignupErrorState());
            Fluttertoast.showToast(
              msg: "Signup Error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          });
        } else {
          userModel = UserModel(
              email: value.user!.email, name: name, uid: value.user!.uid);
          FirebaseFirestore.instance
              .collection(kuserCollection)
              .doc(value.user!.uid)
              .set(userModel!.toMap())
              .then((value) {
            emit(SaveUserDataSuccessState());
            Fluttertoast.showToast(
              msg: "Done Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          }).catchError((e) {
            emit(SignupErrorState());
            Fluttertoast.showToast(
              msg: "Signup Error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          });
        }
      });
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential!.user!.uid);
      navigateTo(context, const HomeScreen());
    }
  }

  Future getPersonData() async {
    persondata = {};
    if (isAdmin) {
      await FirebaseFirestore.instance
          .collection(kadminCollection)
          .doc(userCredential!.user!.uid)
          .get()
          .then((value) {
        persondata = value.data();
        personName = persondata!["name"];
        personEmail = persondata!["email"];
        checkisAdmin = persondata!["isadmin"];
        print('"isAdmin"+ ${checkisAdmin.toString()}');
        emit(GetAdminDataSuccessfully());
      }).catchError((e) {
        Fluttertoast.showToast(
          msg: "Some Problems Happend",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      });
    } else {
      await FirebaseFirestore.instance
          .collection(kuserCollection)
          .doc(userCredential!.user!.uid)
          .get()
          .then((value) {
        persondata = value.data();
        personName = persondata!["name"];
        personEmail = persondata!["email"];
        checkisAdmin = value.data()!['isadmin'];
        print('"isUser"+ ${checkisAdmin.toString()}');
        emit(GetUserDataSuccessfully());
      }).catchError((e) {
        print("Some Problems Happend");
        Fluttertoast.showToast(
          msg: "Some Problems Happend",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      });
    }
  }

  Future getImage(ImageSource source) async {
    addCouponfile = null;
    var image = await addCouponimagePicker.pickImage(source: source);
    if (image != null) {
      addCouponfile = File(image.path);
      emit(SelectedImageState());
    } else {
      emit(NoSelectedImageState());
    }
  }

  void storeCouponItems({
    required companyname,
    required description,
    required couponcode,
    required context,
  }) async {
    emit(AddCouponState());
    Future.delayed(const Duration(seconds: 5));
    final snapShot = await FirebaseFirestore.instance
        .collection('Coupons')
        .doc(couponcode)
        .get();
    if (snapShot.exists) {
      Fluttertoast.showToast(
        msg: "This Code is Existed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      emit(AddCouponCodeExistState());
    } else {
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'CouponImages/${Uri.file(addCouponfile!.path).pathSegments.last}')
          .putFile(addCouponfile!)
          .then((val) {
        val.ref.getDownloadURL().then((value) {
          couponItems = CouponItems(
              logocompany: value,
              companyname: companyname,
              couponcode: couponcode,
              description: description);
          FirebaseFirestore.instance
              .collection('Coupons')
              .doc(couponcode.toString())
              .set(couponItems!.toMap())
              .then((value) {
            emit(AddCouponSavedSuccessfully());
            Fluttertoast.showToast(
              msg: "Data Saved Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          }).catchError((e) {
            emit(AddCouponDataErrorState());
            Fluttertoast.showToast(
              msg: e.toString(),
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
            );
          });
        }).catchError((e) {
          emit(AddImageErrorState());
          Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        });
      }).catchError((e) {
        emit(AddImageStorageErrorState());
        Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
        print(e.toString());
      });
      emit(AllAddCouponStoredSuccessfully());
      Fluttertoast.showToast(
        msg: "The Data stored in Cloud Firestore",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      addCouponfile = null;
      navigateAndFinish(context, const HomeScreen());
    }
  }

  void showCouponData() async {
    ShowcouponDataList = [];
    emit(ShowCouponLoadingState());
    await Future.delayed(const Duration(seconds: 5));
    await FirebaseFirestore.instance.collection('Coupons').get().then((value) {
      value.docs.forEach((element) {
        ShowcouponDataList.add(CouponItems.fromJson(element.data()));
      });
      if (ShowcouponDataList.length == value.docs.length &&
          ShowcouponDataList.isNotEmpty) {
        print(ShowcouponDataList.length);
        emit(ShowCouponDataSuccessfully());
        Fluttertoast.showToast(
          msg: "The Data is Back in Good Shape",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      } else {
        emit(ShowCouponDataIsEmptyState());
        Fluttertoast.showToast(
          msg: "Not Find Data To Display it",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    }).catchError((e) {
      emit(ShowCouponDataErrorState());
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    });
  }

  void deleteCouponDataFromShowScreen(couponcode, String imageFileUrl) async {
    await FirebaseFirestore.instance
        .collection('Coupons')
        .doc(couponcode)
        .delete()
        .then((value) async {
      emit(CouponDeletedSuccessfully());
      Fluttertoast.showToast(
        msg: "Coupon Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      showCouponData();
      var fileUrl = Uri.decodeFull(Path.basename(imageFileUrl))
          .replaceAll(new RegExp(r'(\?alt).*'), '');
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child(fileUrl)
          .delete();
      emit(ImageDeletedSuccessfully());
      Fluttertoast.showToast(
        msg: "ImageDeletedSuccessfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }).catchError((e) {
      emit(CouponErrorDeleted());
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    });
  }

  void getOneCouponItem(code) async {
    emit(GetSpecialDataLoading());
    await Future.delayed(const Duration(seconds: 5));
    codenumber = code;
    data = {};
    await FirebaseFirestore.instance
        .collection("Coupons")
        .doc(code)
        .get()
        .then((value) {
      print(value.data());
      data = value.data();
      companyimage = oldcompnayimage = value.data()!["logocompany"];
      print("Data: $data");
      emit(SpecialDataGettedSuccessfully());
    });
  }

  Future getLogoImage(ImageSource source) async {
    companyimage = null;
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      file = File(image.path);
      companyimage = file;
      emit(SelecteLogoImage());
    } else {
      companyimage = null;
      emit(NoSelectedLogoImageState());
    }
  }

  Widget displayLogoImage() {
    if (companyimage == null) {
      return Image.network(
        "https://www.pixsy.com/wp-content/uploads/2021/04/ben-sweet-2LowviVHZ-E-unsplash-1.jpeg",
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    } else if (companyimage is File) {
      return Image.file(
        companyimage,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    } else {
      print(companyimage.runtimeType);
      return Image.network(
        companyimage,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      );
    }
  }

  void checkOnCouponCode(
      {required companyname, required companydesc, required cuponcode}) async {
    final snapShot = await FirebaseFirestore.instance
        .collection('Coupons')
        .doc(cuponcode)
        .get();
    if (snapShot.exists && cuponcode == codenumber) {
      updateData(
          companyname: companyname,
          companydesc: companydesc,
          cuponcode: cuponcode);
    } else if (snapShot.exists) {
      Fluttertoast.showToast(
        msg: "This Code is Existed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      print("This Code doesn't Existed");
      deleteOldCouponAndaddNewCoupon(
          newlogoImage: companyimage,
          newcompanyname: companyname,
          newcompanydesc: companydesc,
          newcuponcode: cuponcode);
    }
  }

  void updateData(
      {required companyname, required companydesc, required cuponcode}) async {
    if (companyimage is File) {
      print("File");
      deleteAndupdate(
          companyimage: companyimage,
          oldImage: oldcompnayimage,
          companyname: companyname,
          companydesc: companydesc,
          cuponcode: cuponcode);
    } else {
      print("Not File");
      updateTexts(
          companyimage: companyimage,
          companyname: companyname,
          companydesc: companydesc,
          cuponcode: cuponcode);
    }
  }

  void deleteAndupdate(
      {required companyimage,
      required oldImage,
      required companyname,
      required companydesc,
      required cuponcode}) async {
    oldImage = Uri.decodeFull(Path.basename(oldImage))
        .replaceAll(RegExp(r'(\?alt).*'), '');
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(oldImage)
        .delete();
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('CouponImages/${Uri.file(companyimage.path).pathSegments.last}')
        .putFile((companyimage as File))
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        couponItems = CouponItems(
            logocompany: value,
            companyname: companyname,
            couponcode: cuponcode,
            description: companydesc);
        FirebaseFirestore.instance
            .collection('Coupons')
            .doc(cuponcode.toString())
            .update(couponItems!.toMap())
            .then((value) {
          Fluttertoast.showToast(
            msg: "Data Saved Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }).catchError((e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        });
      }).catchError((e) {
        print(e.toString());
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  void updateTexts(
      {required companyimage,
      required companyname,
      required companydesc,
      required cuponcode}) async {
    couponItems = CouponItems(
        logocompany: companyimage,
        companyname: companyname,
        couponcode: cuponcode,
        description: companydesc);
    await FirebaseFirestore.instance
        .collection(kCollection)
        .doc(cuponcode)
        .update(couponItems!.toMap())
        .then((value) {
      Fluttertoast.showToast(
        msg: "Data Saved Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }).catchError((e) {
      Fluttertoast.showToast(
        msg: "Data Saved UnSuccessfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    });
  }

  void deleteOldCouponAndaddNewCoupon(
      {required newlogoImage,
      required newcompanyname,
      required newcompanydesc,
      required newcuponcode}) async {
    oldcompnayimage = Uri.decodeFull(Path.basename(oldcompnayimage))
        .replaceAll(RegExp(r'(\?alt).*'), '');
    print(oldcompnayimage);
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child(oldcompnayimage)
        .delete();
    FirebaseFirestore.instance
        .collection(kCollection)
        .doc(data!['couponcode'])
        .delete()
        .then((value) {
      Fluttertoast.showToast(
        msg: "Coupon Deleted Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      showCouponData();
    }).catchError((e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    });
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('CouponImages/${Uri.file(newlogoImage.path).pathSegments.last}')
        .putFile((newlogoImage as File))
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        couponItems = CouponItems(
            logocompany: value,
            companyname: newcompanyname,
            couponcode: newcuponcode,
            description: newcompanydesc);
        FirebaseFirestore.instance
            .collection('Coupons')
            .doc(newcuponcode.toString())
            .set(couponItems!.toMap())
            .then((value) {
          Fluttertoast.showToast(
            msg: "NewData Saved Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        }).catchError((e) {
          Fluttertoast.showToast(
            msg: e.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        });
      }).catchError((e) {
        print(e.toString());
      });
    }).catchError((e) {
      print(e.toString());
    });
  }

  Future signOut(context) async {
    await FirebaseAuth.instance.signOut();
    emit(UserSignOutSuccessfully());
    navigateAndFinish(
        context,
        ChoiceScreen(
          text: kLoginText,
        ));
  }
}
