// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shopy/models/profile_model.dart';
import 'package:shopy/shared/netowrk/constants.dart';
import 'package:shopy/shared/netowrk/end_points.dart';
import 'package:shopy/shared/netowrk/remote/dio_helper.dart';

enum ProfileDataStatus { success, error, loading }

class ProfileProvider with ChangeNotifier {
  ProfileDataStatus? profileDataStatus;
  ProfileModel? profileModel;

  void getProfileData() {
    profileDataStatus = ProfileDataStatus.loading;
    print(profileDataStatus);
    DioHelper.getData(url: PROFILE, token: token).then((value) {
      profileModel = ProfileModel.fromJson(value.data);
      print(value.data);
      profileDataStatus = ProfileDataStatus.success;
      print(profileDataStatus);
      notifyListeners();
    }).catchError((error) {
      profileDataStatus = ProfileDataStatus.error;
      print(profileDataStatus);
      print(error);
      notifyListeners();
    });
  }
}
