// ignore_for_file: unnecessary_getters_setters, avoid_print

import 'package:flutter/material.dart';
import 'package:shopy/models/login_model.dart';
import 'package:shopy/shared/netowrk/constants.dart';
import 'package:shopy/shared/netowrk/end_points.dart';
import 'package:shopy/shared/netowrk/remote/dio_helper.dart';

enum Status {
  notLoggedIn,
  notRegistered,
  loggenIn,
  regesterd,
  authenticating,
  registering,
  loggedOut
}

class NetworkProvider with ChangeNotifier {
  Status loggedInStatus = Status.notLoggedIn;
  Status signUpStatus = Status.notRegistered;

  LoginModel? loginModel;
  LoginModel? registerModel;

  Future<void> userLogin(
      {required String email,
       required String password}) async {
    loggedInStatus = Status.authenticating;
    notifyListeners();
    print("getting data");
    await DioHelper.postData(
      url: LOGIN,
      data: {"email": email, "password": password},
    ).then((value) {
      print(value);
      print(loggedInStatus);
      loginModel = LoginModel.fromJson(value.data);
      print(value.data['status']);
      if (value.data['status']) {
        loggedInStatus = Status.loggenIn;
        if (loginModel!.data != null) {
          print("token : ${loginModel!.data!.token}");
          token = loginModel!.data!.token;
        }
      } else {
        loggedInStatus = Status.notLoggedIn;
      }

      notifyListeners();
    }).catchError((error) {
      print('the error is $error');
    });
    notifyListeners();
  }

  Future<void> userRegister(
      {required String name,
      required String email,
      required String password,
      required String phone}) async {
    signUpStatus = Status.registering;
    notifyListeners();
    print("getting data");
   await DioHelper.postData(
      url: REGISTER,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone
      },
    ).then((value) {
      print(value);
      print(signUpStatus);
      registerModel = LoginModel.fromJson(value.data);
      print(value.data['status']);
      if (value.data['status']) {
        signUpStatus = Status.regesterd;
        if (registerModel!.data != null) {
          print("token : ${registerModel!.data!.token}");
          token = registerModel!.data!.token;
        }
      } else {
        signUpStatus = Status.notRegistered;
      }

      notifyListeners();
    }).catchError((error) {
      print("error : $error");
      signUpStatus = Status.notRegistered;
    });
    notifyListeners();
  }
}
