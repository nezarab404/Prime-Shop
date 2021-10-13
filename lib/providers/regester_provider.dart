// ignore_for_file: unnecessary_getters_setters, avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shopy/models/login_model.dart';
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

class RegesterProvider with ChangeNotifier {
  Status _loggedInStatus = Status.notLoggedIn;
  Status _signUpStatus = Status.notRegistered;

  Response? loginResponse; //useless
  LoginModel? loginModel;

  Status get loggedInStatus => _loggedInStatus;

  set loggedInStatus(Status value) {
    _loggedInStatus = value;
  }

  Status get signUpStatus => _signUpStatus;

  set signUpStatus(Status value) {
    _signUpStatus = value;
  }

  Future<void> userLogin(
      {required String email, required String password}) async {
    _loggedInStatus = Status.authenticating;
    notifyListeners();
    print("getting data");
    await DioHelper.postData(
      url: LOGIN,
      data: {"email": email, "password": password},
    ).then((value) {
      print(value);
      print(_loggedInStatus);
      loginResponse = value; //useless
      loginModel = LoginModel.fromJson(value.data);
      print(value.data['status']);
      if (value.data['status']) {
        loggedInStatus = Status.loggenIn;
        if (loginModel!.data != null) {
          print("token : ${loginModel!.data!.token}");
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
}
