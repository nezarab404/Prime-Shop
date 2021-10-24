import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/providers/search_provider.dart';
import 'package:shopy/shared/componenst/product_view.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchProvider>(
      create: (_) => SearchProvider(),
      builder: (ctx, _) {
        return buildBody(ctx);
      },
    );
  }

  Widget buildBody(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Searching for product",
          style: TextStyle(color: Colors.indigo),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (provider.searchStatus == SearchStatus.loading)
              const LinearProgressIndicator(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextField(
                    controller: _search,
                    onChanged: (text) {
                      provider.searchProduct(text);
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        icon: const Icon(Icons.search),
                        labelText: "Search"),
                  ),
                  getAppropriateWidget(provider, context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getAppropriateWidget(SearchProvider provider, BuildContext context) {
    if (provider.searchModel != null) {
      if (provider.searchModel!.data!.data.isNotEmpty) {
        return SizedBox(
          height: MediaQuery.of(context).size.height - 190,
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ProductView(
                context: context,
                product: provider.searchModel!.data!.data[index],
                isSearch: true,
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 1,
                color: Colors.grey,
              );
            },
            itemCount: provider.searchModel!.data!.data.length,
          ),
        );
      } else if (provider.searchModel!.data!.data.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/noResult.png"),
              const Text("No Result Found"),
            ],
          ),
        );
      }
    }

    return Container(
      color: Colors.amber,
    );
  }
}
