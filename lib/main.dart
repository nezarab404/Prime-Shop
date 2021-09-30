import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/providers/network_provider.dart';
import 'package:shopy/providers/shop_provider.dart';
import 'package:shopy/screens/login/login_screen.dart';

import 'screens/on_boarding/on_boarding.dart';
import 'package:shopy/shared/netowrk/keys.dart';
import 'package:shopy/shared/netowrk/local/shared_helper.dart';
import 'package:shopy/shared/netowrk/remote/dio_helper.dart';

import 'screens/shop layout/shop_layout.dart';
import 'shared/netowrk/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedHelper.init();
  DioHelper.init();
  //SharedHelper.saveData(key: ONBOARDING, value: false);
  Widget widget;
  // Provider.debugCheckInvalidValueType = null;

  bool? onBoarding = SharedHelper.getData(key: ONBOARDING);
  token = SharedHelper.getData(key: TOKEN);

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoarding();
  }

  runApp(MyApp(
    widget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NetworkProvider(),
      child: ChangeNotifierProvider(
        create: (_) => ShopProvider()
          ..getHomeData()
          ..getCategoriesData()
          ..getFavoritesData(),
        child: MaterialApp(
          title: 'Shopy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: widget,
        ),
      ),
    );
  }
}
