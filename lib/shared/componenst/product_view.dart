import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/models/home_model.dart';
import 'package:shopy/providers/shop_provider.dart';

class ProductView extends StatelessWidget {
  const ProductView(
      {Key? key,
      required this.context,
      required this.product,
      this.isSearch = false})
      : super(key: key);

  final ProductModel product;
  final BuildContext context;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  width: 120,
                  height: 100,
                  child: Image(
                    image: NetworkImage(product.image!),
                  ),
                ),
                if (!isSearch && product.discount != 0)
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset("assets/images/discount1.png"),
                    ),
                  )
              ],
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
                          "${(product.price * 0.063653571).round()} \$",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (!isSearch && product.discount != 0)
                          Text(
                            "${(product.oldPrice * 0.063653571).round()} \$",
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

  // @override
  // Widget build(BuildContext context) {
  //   var provider = Provider.of<ShopProvider>(context);
  //   return Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(width: 1, color: Colors.indigo),
  //         borderRadius: BorderRadius.circular(30),
  //         color: Colors.white,
  //       ),
  //       child: Padding(
  //         padding: const EdgeInsets.all(8),
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Stack(
  //               alignment: AlignmentDirectional.topStart,
  //               children: [
  //                 SizedBox(
  //                   height: 180,
  //                   width: double.infinity,
  //                   child: Image.network(
  //                     product.image!,
  //                     fit: BoxFit.contain,
  //                   ),
  //                 ),
  //                 if (!isSearch! && product.discount != 0)
  //                   Padding(
  //                     padding: const EdgeInsets.all(0.0),
  //                     child: SizedBox(
  //                       height: 50,
  //                       width: 50,
  //                       child: Image.asset("assets/images/discount1.png"),
  //                     ),
  //                   )
  //               ],
  //             ),
  //             Text(
  //               product.name!,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //               style:
  //                   const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   "${(product.price * 0.063653571).round()}\$",
  //                   // convert from EGP to USD
  //                   style: const TextStyle(
  //                     color: Colors.orange,
  //                     fontSize: 12,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 if (!isSearch! && product.discount != 0)
  //                   Text(
  //                     "${(product.oldPrice * 0.063653571).round()} \$",
  //                     style: const TextStyle(
  //                       color: Colors.grey,
  //                       fontSize: 10,
  //                       decoration: TextDecoration.lineThrough,
  //                     ),
  //                   ),
  //                 CircleAvatar(
  //                   backgroundColor: provider.favorites[product.id] ?? false
  //                       ? Colors.indigo
  //                       : Colors.orange[150],
  //                   child: IconButton(
  //                     onPressed: () {
  //                       provider.changeFavorites(product.id!)?.then((value) {
  //                         print(provider.changeFavoritesStatus);
  //                         if (provider.changeFavoritesStatus ==
  //                             ChangeFavoritesStatus.error) {
  //                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                               content: Text(
  //                                   provider.changeFavoritesModel!.message!),
  //                               backgroundColor: Colors.red));
  //                         }
  //                       });
  //                     },
  //                     icon: Icon(
  //                       provider.favorites[product.id] ?? false
  //                           ? Icons.shopping_cart
  //                           : Icons.shopping_cart_outlined,
  //                     ),
  //                     iconSize: 18,
  //                     color: provider.favorites[product.id] ?? false
  //                         ? Colors.white
  //                         : Colors.black,
  //                   ),
  //                 ),
  //               ],
  //             )
  //           ],
  //         ),
  //       ));
  // }
}
