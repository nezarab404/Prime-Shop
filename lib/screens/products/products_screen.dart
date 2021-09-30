// ignore_for_file: avoid_print

import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/models/categories_model.dart';
import 'package:shopy/models/home_model.dart';
import 'package:shopy/providers/shop_provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);

    //   if (provider.changeFavoritesStatus == ChangeFavoritesStatus.success ){
    //     showToast(context: context, msg: "success", color: Colors.green);
    //   }

    //  if (provider.changeFavoritesStatus == ChangeFavoritesStatus.error ){
    //     showToast(context: context, msg: "error", color: Colors.red);
    //   }

    return provider.homeModel == null
        ? const Center(child: CircularProgressIndicator())
        : buildBody(
            provider.homeModel!, provider.categoriesModel!, provider, context);
  }

  Widget buildBody(HomeModel homeModel, CategoriesModel categoriesModel,
      ShopProvider provider, BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeModel.data!.banners
                  .map((e) => Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: Image(
                          image: NetworkImage(e.image!),
                          fit: BoxFit.fill,
                        ),
                      ))
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                height: 200,
                viewportFraction: 0.8,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayAnimationDuration: const Duration(seconds: 1),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          provider.changeBottom(1);
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          categoriesListItem(categoriesModel.data!.data[index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 20,
                      ),
                      itemCount: categoriesModel.data!.data.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "New Products",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                childAspectRatio: 1 / 1.98,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: List.generate(
                  homeModel.data!.products.length,
                  (index) => buildGridItem(
                      homeModel.data!.products[index], provider, context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGridItem(
      ProductModel product, ShopProvider provider, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.indigo),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                //color: Colors.white,
                child: Image(
                  image: NetworkImage(product.image!),
                  width: double.infinity,
                  height: 180,
                ),
              ),
              if (product.discount != 0)
                Positioned(
                  top: 0,
                  left: 0,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Image.asset('assets/images/discount1.png'),
                  ),
                )
            ],
          ),
          Text(
            product.name!,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                "${(product.price * 0.063653571).round()} \$",
                // convert from EGP to USD
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              if (product.discount != 0)
                Text(
                  "${(product.oldPrice * 0.063653571).round()} \$",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              const Spacer(),
              CircleAvatar(
                backgroundColor: provider.favorites[product.id] ?? false
                    ? Colors.red
                    : Colors.orange[150],
                child: IconButton(
                  onPressed: () {
                    provider.changeFavorites(product.id!)?.then((value) {
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
                      ? Icons.favorite
                      : Icons.favorite_border),
                  iconSize: 18,
                  color: provider.favorites[product.id] ?? false
                      ? Colors.white
                      : Colors.black,
                ),
              ),

            ],
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Add To Cart",
                  style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }

  Container newMethod() {
    return Container(
      transform: Matrix4.rotationZ(-pi / 4),
      color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: const Text(
        "DISCOUNT",
        style: TextStyle(color: Colors.white, fontSize: 10),
      ),
    );
  }

  Widget categoriesListItem(DataModel model) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(90),
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90),
        ),
        child: Stack(
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 100,
              width: 100,
              fit: BoxFit.fill,
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                border: Border.all(width: 1, color: Colors.indigo),
                color: Colors.black26,
              ),
              child: Text(
                model.name!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//178.22.122.100, 178.51.200.2
