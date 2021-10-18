// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shopy/models/search_model.dart';
import 'package:shopy/shared/netowrk/constants.dart';
import 'package:shopy/shared/netowrk/end_points.dart';
import 'package:shopy/shared/netowrk/remote/dio_helper.dart';

enum SearchStatus {init, loading, success, falied }

class SearchProvider with ChangeNotifier {
  SearchStatus? searchStatus = SearchStatus.init;
  SearchModel? searchModel;

  void searchProduct(String text) {
    searchStatus = SearchStatus.loading;
    print(searchStatus);
    notifyListeners();
    DioHelper.postData(url: SEARCH, data: {'text': text}, token: token)
        .then((value) {
      searchModel = SearchModel.fromJson(value.data);
      searchStatus = SearchStatus.success;
      
      print(searchStatus);
      print(value.data);
      notifyListeners();
    }).catchError((error) {
      searchStatus = SearchStatus.falied;
      print(error);
      print(searchStatus);
      notifyListeners();
    });
  }
}
