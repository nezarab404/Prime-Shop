import 'home_model.dart';

class FavoritesModel {
  bool? status;
  FavoritesDataModel? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = FavoritesDataModel.fromJson(json['data']);
  }
}

class FavoritesDataModel {
  List<FavoritesItemDataModel> data = [];

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(FavoritesItemDataModel.fromJson(element));
    });
  }
}

class FavoritesItemDataModel {
  int? id;
  ProductModel? product;

  FavoritesItemDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductModel.fromJson(json['product']);
  }
}

// class FavoritesProductModel {
//   int? id;
//   dynamic price;
//   dynamic oldPrice;
//   int? discount;
//   String? image;
//   String? name;
//   String? description;

//   FavoritesProductModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     price = json['price'];
//     oldPrice = json['old_price'];
//     discount = json['discount'];
//     image = json['image'];
//     name = json['name'];
//     description = json['description'];
//   }
// }
