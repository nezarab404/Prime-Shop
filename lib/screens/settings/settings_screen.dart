import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/models/login_model.dart';
import 'package:shopy/providers/shop_provider.dart';
import 'package:shopy/screens/login/login_screen.dart';
import 'package:shopy/shared/netowrk/keys.dart';
import 'package:shopy/shared/netowrk/local/shared_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(
        Provider.of<ShopProvider>(context).profileModel!.data!, context);
  }

  Widget buildBody(UserData model, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  const CircleAvatar(
                    radius: 55,
                    backgroundImage: NetworkImage(
                        "https://e7.pngegg.com/pngimages/109/994/png-clipart-teacher-student-college-school-education-avatars-child-face-thumbnail.png"),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        onPressed: () {},
                        color: Colors.orange,
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
                style: const TextStyle(
                    fontSize: 25,
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.alternate_email),
                      Text(model.email!),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.phone),
                      Text(model.phone!),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: const Text("Dark Mood"),
                  trailing: Switch(
                    value: Provider.of<ShopProvider>(context).switchVal,
                    onChanged: (value) =>
                        Provider.of<ShopProvider>(context, listen: false)
                            .changeSwitch(value),
                  ),
                ),
              ),
              Card(
                color: Colors.orange,
                child: ListTile(
                  onTap: () {
                    SharedHelper.removeData(key: TOKEN).then((value) {
                      if (value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()));
                      }
                    });
                  },
                  title: const Center(child: Text("Log Out")),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
