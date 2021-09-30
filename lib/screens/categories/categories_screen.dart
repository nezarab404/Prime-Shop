import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/models/categories_model.dart';
import 'package:shopy/providers/shop_provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);
    return provider.categoriesModel == null
        ? const CircularProgressIndicator()
        : buildListView(provider.categoriesModel!);
  }

  Widget buildListView(CategoriesModel model) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return buildCategoriesListItem(model.data!.data[index]);
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

  Widget buildCategoriesListItem(DataModel category) {
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
                image: NetworkImage(category.image!),
              ),
            ),
            Text(
              "${category.name}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            IconButton(
              onPressed: () {},
              color: Colors.orange,
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
