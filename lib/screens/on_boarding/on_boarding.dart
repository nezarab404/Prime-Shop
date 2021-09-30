import 'package:flutter/material.dart';
import 'package:shopy/shared/netowrk/keys.dart';
import 'package:shopy/shared/netowrk/local/shared_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login/login_screen.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _pageController = PageController();
  List<Color> x = [Colors.amber, Colors.blue, Colors.deepPurpleAccent];
  List images = [
    'assets/images/pic1.png',
    'assets/images/pic2.png',
    'assets/images/pic3.png',
  ];
  List titles = [
    'wellcome to my shop app',
    'wellcome to my shop cart',
    'wellcome to my shop phone',
  ];

  void submit() {
    SharedHelper.saveData(key: ONBOARDING, value: true).then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            TextButton(
                onPressed: () {
                  submit();
                },
                child: const Text(
                  'SKIP',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    controller: _pageController,
                    itemCount: 3,
                    itemBuilder: (ctx, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 300,
                            height: 300,
                            child: Image.asset(
                              images[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                titles[index],
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      count: 3,
                      effect: const ExpandingDotsEffect(),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        if (_pageController.page!.toInt() != 2) {
                          _pageController.animateToPage(
                              _pageController.page!.toInt() + 1,
                              duration: const Duration(milliseconds: 1000),
                              curve: Curves.easeInOut);
                        } else {
                          submit();
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.indigo,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
