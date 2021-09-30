import 'package:shopy/models/home_model.dart';

class ChangeFavoritesModel {
  bool? status;
  String? message;
  ChangeFavoritesModelData? data;

  ChangeFavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = ChangeFavoritesModelData.fromJson(json['data']);
  }
}

class ChangeFavoritesModelData {
  int? id;
  ProductModel? product;

  ChangeFavoritesModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
  }
}
