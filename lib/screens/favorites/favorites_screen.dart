import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/models/favorites_model.dart';
import 'package:shopy/models/home_model.dart';
import 'package:shopy/providers/shop_provider.dart';
import 'package:shopy/shared/componenst/product_view.dart';

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
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/empty.png"),
                  const Text(
                    "No Items",
                    style: TextStyle(fontSize: 25),
                  )
                ],
              ))
            : buildListView(provider.favoritesModel!);
  }

  Widget buildListView(FavoritesModel model) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ProductView(
              context: context, product: model.data!.data[index].product!);
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

  Widget buildCategoriesListItem(ProductModel product, BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
          border: Border.all(color: Colors.indigo),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                width: 120,
                height: 100,
                child: Image(
                  image: NetworkImage(product.image!),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text(
                    "${product.name}",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    softWrap: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${(product.price * 0.063653571).round()}",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (product.discount != 0)
                          Text(
                            "${(product.oldPrice * 0.063653571).round()}",
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                        else
                          const Spacer()
                      ],
                    ),
                  )
                ],
              ),
            ),
            CircleAvatar(
              backgroundColor: provider.favorites[product.id] ?? false
                  ? Colors.red
                  : Colors.orange[150],
              child: IconButton(
                onPressed: () {
                  provider.changeFavorites(product.id!)?.then((value) {
                    // ignore: avoid_print
                    print(provider.changeFavoritesStatus);
                    if (provider.changeFavoritesStatus ==
                        ChangeFavoritesStatus.error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(provider.changeFavoritesModel!.message!),
                          backgroundColor: Colors.red));
                    }
                  });
                },
                icon: Icon(provider.favorites[product.id] ?? false
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_outlined),
                iconSize: 18,
                color: provider.favorites[product.id] ?? false
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
