/*
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/auth/introController/IntroController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../data/model/auth/introModel/IntroResponse.dart';
import 'package:intro_screen_onboarding_flutter/intro_app.dart';

class IntoSliderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntoSliderScreenState();
  }
}

class _IntoSliderScreenState extends State<IntoSliderScreen> {
  List<Introduction> slides = [];
  final introController = Get.put(IntroController());

  @override
  void initState() {
    super.initState();
    introController.getIntroData().then((response) {
      // if (response.statusCode == 200) {
        setState(() {
          introController.introList.forEach((intro) {
            slides.add(
              Introduction(
                title: intro.title!,
                subTitle: intro.content!,
                  imageWidth: double.infinity,
                imageUrl: //intro.image!
                'assets/intro1.png',
              ),
            );
          });
        });
      // } else {
      //   // Handle error
      // }
    });
  }

  List<Widget> generateListCustomTabs() {
    return slides.map((slide) {
      return Container(
        margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            // Image.network(
            //   slide.imageUrl,
            //   width: MediaQuery.of(context).size.width,
            //   height: 40.h,
            // ),
            Image.asset(
              'assets/intro1.png',
              width: MediaQuery.of(context).size.width,
               height: 40.h,
            ),
            SizedBox(height: 1.h),
            Text(
              slide.title!,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16.sp,
                fontFamily: 'lexend_extraBold',
                fontWeight: FontWeight.w800,
                color: MyColors.Dark1,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              slide.subTitle!,
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 2.3.h,
                fontFamily: 'lexend_extraBold',
                fontWeight: FontWeight.w800,
                color: MyColors.Dark2,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(MyColors.MainColor),
      foregroundColor: MaterialStateProperty.all<Color>(MyColors.MainColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (slides.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Container(
        color: MyColors.BackGroundColor,
        margin: EdgeInsetsDirectional.only(start: 1.h, end: 1.h),
        child: IntroScreenOnboarding(
          key: UniqueKey(),
          introductionList: slides,
          onTapSkipButton: () {
            onDonePress();
          },
          skipTextStyle: TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_regular',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark2),
          foregroundColor: MyColors.MainColor,
        ),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/Login_screen",
      ModalRoute.withName('/Login_screen'),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/auth/introController/IntroController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../data/model/auth/introModel/IntroResponse.dart';

class IntoSliderScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntoSliderScreenState();
  }
}

class _IntoSliderScreenState extends State<IntoSliderScreen> {
  List<ContentConfig> slides = [];
  final introController = Get.put(IntroController());

  @override
  void initState() {
    super.initState();
    introController.getIntroData().then((response) {
      // if (response.statusCode == 200) {
        setState(() {
          introController.introList.forEach((intro) {
            slides.add(
              ContentConfig(
                title: intro.title!,
                description: intro.content!,
                pathImage: intro.image!,
              ),
            );
          });
        });
      // } else {
      //   // Handle error
      // }
    });
  }

  List<Widget> generateListCustomTabs() {
    return slides.map((slide) {
      return Container(
        margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
        width: double.infinity,
        height: double.infinity,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 3.h),
            //SvgPicture.asset(slide.pathImage!,width: MediaQuery.of(context).size.width,height: 50.h,),
            Image.network(
              slide.pathImage!,
              width: MediaQuery.of(context).size.width,
              height: 40.h,
            ),
            SizedBox(height: 2.h),
            Center(
              child: Text(
                slide.title!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: 'lexend_extraBold',
                  fontWeight: FontWeight.w800,
                  color: MyColors.Dark1,
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              slide.description!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'lexend_extraBold',
                fontWeight: FontWeight.w300,
                color: MyColors.Dark2,),
            ),
          ],
        ),
      );
    }).toList();
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(MyColors.MainColor),
      foregroundColor: MaterialStateProperty.all<Color>(MyColors.MainColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (slides.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      body: Container(
        color: MyColors.BackGroundColor,
        margin: EdgeInsetsDirectional.only(start: 1.h, end: 1.h),
        child: IntroSlider(
          key: UniqueKey(),
          listContentConfig: slides,
          renderSkipBtn: Text(
            'skip'.tr(),
            style: TextStyle(
              fontSize: 12.sp,
              fontFamily: 'lexend_regular',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark2,
            ),
          ),
          renderNextBtn: Text(
            'continue'.tr(),
            style: TextStyle(
              fontSize: 9.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          nextButtonStyle: myButtonStyle(),
          renderDoneBtn: Text(
            'login'.tr(),
            style: TextStyle(
              fontSize: 9.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          onDonePress: onDonePress,
          doneButtonStyle: myButtonStyle(),
          indicatorConfig: IndicatorConfig(
            sizeIndicator: 1.2.h,
            colorActiveIndicator: MyColors.MainColor,
            colorIndicator: MyColors.MainColor,
            typeIndicatorAnimation: TypeIndicatorAnimation.sizeTransition,
          ),
          listCustomTabs: generateListCustomTabs(),
          scrollPhysics: BouncingScrollPhysics(),
          backgroundColorAllTabs: Colors.white,
        ),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/Login_screen",
      ModalRoute.withName('/Login_screen'),
    );
  }
}
