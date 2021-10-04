import 'dart:io';

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


//  This should be used while in development mode,
// do NOT do this when you want to release to production,
// the aim of this answer is to make the development a bit easier for you,
// for production, you need to fix your certificate issue and use it properly,
// look at the other answers for this as it might be helpful for your case.
  HttpOverrides.global = MyHttpOverrides();



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
          ..getFavoritesData()..getProfileData(),
        child:MaterialApp(
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


 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}