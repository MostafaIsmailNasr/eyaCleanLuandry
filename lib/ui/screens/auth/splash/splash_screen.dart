import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:EyaCleanLaundry/conustant/my_colors.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}
class _SplashScreen extends State<SplashScreen>{

  @override
  void initState() {
    super.initState();
    time();
  }

  time() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await Timer(
      const Duration(seconds: 5),
          () {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/change_language_screen", ModalRoute.withName('/change_language_screen'));
        // if (prefs.getBool("isLogin") == true) {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, "/home_screen", ModalRoute.withName('/home_screen'));
        // } else {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, "/login_screen", ModalRoute.withName('/login_screen'));
        // }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Center(
              child: //Image.asset('assets/eya_logo.png')
              SvgPicture.asset('assets/eya_logo.svg')
              ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(bottom: 50),
            child: Center(
              child: JumpingDots(
                color: MyColors.LoaderColor,
                radius: 10,
                numberOfDots: 4,innerPadding: 5,
                animationDuration: const Duration(milliseconds: 200),
              ),
            ),
          )
        ],
      ),
    );
  }

}