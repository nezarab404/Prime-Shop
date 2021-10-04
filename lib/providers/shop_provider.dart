// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:shopy/models/categories_model.dart';
import 'package:shopy/models/change_favorites_model.dart';
import 'package:shopy/models/favorites_model.dart';
import 'package:shopy/models/home_model.dart';
import 'package:shopy/models/profile_model.dart';
import 'package:shopy/screens/categories/categories_screen.dart';
import 'package:shopy/screens/favorites/favorites_screen.dart';
import 'package:shopy/screens/products/products_screen.dart';
import 'package:shopy/screens/settings/settings_screen.dart';
import 'package:shopy/shared/netowrk/constants.dart';
import 'package:shopy/shared/netowrk/end_points.dart';
import 'package:shopy/shared/netowrk/remote/dio_helper.dart';

enum ShopDataStatus { loading, success, error }

enum CategoriesDataStatus { loading, success, error }

enum FavoritesDataStatus { loading, success, error }

enum ChangeFavoritesStatus { loading, success, error }
enum ProfileDataStatus { success, error, loading }


class ShopProvider with ChangeNotifier {
  int currentIndex = 0;

  HomeModel? homeModel;
  CategoriesModel? categoriesModel;
  FavoritesModel? favoritesModel;
  ChangeFavoritesModel? changeFavoritesModel;

  ShopDataStatus? shopDataStatus;
  CategoriesDataStatus? categoriesDataStatus;
  FavoritesDataStatus? favoritesDataStatus;
  ChangeFavoritesStatus? changeFavoritesStatus;

  Map<int, bool> favorites = {};

  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const SettingsScreen()
  ];

  List<String> appBarTitles = [
    "Nezar Shop",
    "Categories",
    "Favorites",
    "Settings"
  ];

  Widget getBottomScreen() {
    notifyListeners();
    return bottomScreens[currentIndex];
  }

  void changeBottom(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void getHomeData() {
    shopDataStatus = ShopDataStatus.loading;
    print(shopDataStatus);

    
      DioHelper.getData(url: HOME, token: token).then((value) {
        homeModel = HomeModel.fromJson(value.data);
        shopDataStatus = ShopDataStatus.success;
        print(shopDataStatus);
        for (var product in homeModel!.data!.products) {
          favorites[product.id!] = product.inFavorites!;
        }
       // print("home : $favorites");
        notifyListeners();
      }).catchError((error) {
        print(error.toString());
        shopDataStatus = ShopDataStatus.error;
        print(shopDataStatus);
        notifyListeners();
      });
    
  }

  void getCategoriesData() {
    categoriesDataStatus = CategoriesDataStatus.loading;
    print(categoriesDataStatus);

    DioHelper.getData(url: CATEGORIES, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      categoriesDataStatus = CategoriesDataStatus.success;
      print(categoriesDataStatus);
      notifyListeners();
    }).catchError((error) {
      print(error.toString());
      categoriesDataStatus = CategoriesDataStatus.error;
      print(categoriesDataStatus);
      notifyListeners();
    });
  }

  void getFavoritesData() {
    favoritesDataStatus = FavoritesDataStatus.loading;
    print(favoritesDataStatus);

    DioHelper.getData(url: FAVORITES, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      favoritesDataStatus = FavoritesDataStatus.success;
      print(favoritesDataStatus);
      print("favorites : ${favoritesModel!.data!.data.length}");
      notifyListeners();
    }).catchError((error) {
      print(error.toString());
      favoritesDataStatus = FavoritesDataStatus.error;
      print(favoritesDataStatus);
      notifyListeners();
    });
  }

  Future<void>? changeFavorites(int id) {
    favorites[id] = favorites[id] == null ? true : !favorites[id]!;
    notifyListeners();
    changeFavoritesStatus = ChangeFavoritesStatus.loading;
    print(changeFavoritesStatus);
    DioHelper.postData(url: FAVORITES, data: {'product_id': id}, token: token)
        .then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);
      changeFavoritesStatus = ChangeFavoritesStatus.success;
      print(changeFavoritesStatus);
      if (!changeFavoritesModel!.status!) {
        favorites[id] = favorites[id] == null ? true : !favorites[id]!;
        notifyListeners();
      }
      getFavoritesData();
      notifyListeners();
    }).catchError((error) {
      changeFavoritesStatus = ChangeFavoritesStatus.error;
      notifyListeners();
      print(changeFavoritesStatus);
    });
  }


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
