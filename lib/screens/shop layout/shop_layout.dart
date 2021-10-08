import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/providers/shop_provider.dart';
import 'package:shopy/screens/search/search_screen.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ShopProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          provider.appBarTitles[provider.currentIndex],
          style: const TextStyle(
              color: Colors.indigo, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()));
            },
            icon: const Icon(Icons.search),
            color: Colors.indigo,
            highlightColor: Colors.indigoAccent,
          ),
        ],
      ),
      body: provider.bottomScreens[provider.currentIndex],
      bottomNavigationBar: curvedBNB(provider, context),
    );
  }

  CurvedNavigationBar curvedBNB(ShopProvider provider, BuildContext context) {
    return CurvedNavigationBar(
      index: provider.currentIndex,
      backgroundColor: Colors.white,
      color: Colors.indigo,
      buttonBackgroundColor: Colors.indigo,
      height: 50,
      onTap: (index) {
        Provider.of<ShopProvider>(context, listen: false).changeBottom(index);
      },
      items: [
        buildBottomIcon(provider, Icons.home, 0, "Home"),
        buildBottomIcon(provider, Icons.favorite, 1, "Favorite"),
        buildBottomIcon(provider, Icons.shopping_cart, 2, "Categories"),
        buildBottomIcon(provider, Icons.settings, 3, "Settings"),
      ],
    );
  }

  Widget buildBottomIcon(
      ShopProvider provider, IconData icon, int index, String text) {
    return Icon(
      icon,
      color: provider.currentIndex == index ? Colors.white : Colors.orange,
    );
  }

  BottomNavigationBar buildBNB(BuildContext context, ShopProvider provider) {
    return BottomNavigationBar(
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.grey,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.category), label: "Categories"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.favorite), label: "Favorite"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: "Settings"),
      ],
      currentIndex: provider.currentIndex,
      onTap: (index) {
        Provider.of<ShopProvider>(context, listen: false).changeBottom(index);
      },
    );
  }
}


// TODO: SIGN OUT 
// Container(
//         alignment: Alignment.center,
//         child: TextButton(
//           child: const Text("Sign Out"),
//           onPressed: () {
//             SharedHelper.removeData(key: TOKEN).then((value) {
//               if (value) {
//                 Navigator.pushReplacement(context,
//                     MaterialPageRoute(builder: (_) => const LoginScreen()));
//               }
//             });
//           },
//         ),
//       ),