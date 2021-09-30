import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/models/favorites_model.dart';
import 'package:shopy/models/home_model.dart';
import 'package:shopy/providers/shop_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);
    return provider.categoriesModel == null
        ? const CircularProgressIndicator()
        : provider.favoritesModel!.data!.data.isEmpty
            ? const Text("No Items")
            : buildListView(provider.favoritesModel!);
  }

  Widget buildListView(FavoritesModel model) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildCategoriesListItem(model.data!.data[index].product!);
        },
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
            color: Colors.grey,
          );
        },
        itemCount: model.data!.data.length,
      ),
    );
  }

  Widget buildCategoriesListItem(ProductModel product) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(color: Colors.indigo),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image(
                width: 130,
                image: NetworkImage(product.image!),
              ),
            ),
            Expanded(
              child: Text(
                "${product.name}",
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                softWrap: true,
              ),
            ),
            IconButton(
                onPressed: () {
                  Provider.of<ShopProvider>(context, listen: false)
                      .changeFavorites(product.id!);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
