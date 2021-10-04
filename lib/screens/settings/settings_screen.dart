import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/models/login_model.dart';
import 'package:shopy/providers/shop_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(Provider.of<ShopProvider>(context).profileModel!.data!);
  }

  Widget buildBody(UserData model) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
               CircleAvatar(
                radius: 60,
               backgroundImage: NetworkImage(model.image!),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
           Text(
            model.name!,
            style: const TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(model.email!),
              Text(model.phone!),
            ],
          ),
        ],
      ),
    );
  }
}