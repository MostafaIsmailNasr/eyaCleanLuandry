import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../business/aboutUsController/AboutUsController.dart';
import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../conustant/my_colors.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:convert';
import 'dart:math' as math;

class AboutAppScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AboutAppScreen();
  }
}

class _AboutAppScreen extends State<AboutAppScreen>{
  final aboutUsController = Get.put(AboutUsController());
  final changeLanguageController = Get.put(ChangeLanguageController());
  @override
  void initState() {
    aboutUsController.aboutUs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BGColor,
      appBar: AppBar(
        backgroundColor: MyColors.BGColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Transform.rotate(
                angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
                child: SvgPicture.asset('assets/back.svg',))
        ),
        title: Center(
          child: Text(
              'about_app'.tr(), style:  TextStyle(fontSize: 14.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark1)),
        ),
      ),
      body: OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
          ){
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return Obx(() => !aboutUsController.isLoading.value?
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin:  EdgeInsetsDirectional.only(end: 1.5.h,start: 1.5.h,bottom: 1.5.h),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 2.h,),
                      Text('about_app'.tr(), style:  TextStyle(fontSize: 14.sp,
                          fontFamily: 'lexend_bold',
                          fontWeight: FontWeight.w800,
                          color: MyColors.Dark1)),
                      SizedBox(height: 1.h,),
                      Html(
                        data: aboutUsController.aboutAsResponse.value.data!.content??"",
                      ),
                      SizedBox(height: 2.h),
                      Text('contact_us'.tr(), style:  TextStyle(fontSize: 14.sp,
                          fontFamily: 'lexend_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1)),
                      SizedBox(height: 1.h),
                      GestureDetector(
                        onTap: (){
                          var phone=aboutUsController.socialResponse.value.data!.contactUs!.value![1].link.toString();
                          _makePhoneCall('tel:$phone');
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/call_calling.svg',width: 3.h,height: 3.h),
                            SizedBox(width: 1.h),
                            Text(aboutUsController.socialResponse.value.data?.contactUs!.value![1].link.toString()??"", style:  TextStyle(fontSize: 12.sp,
                                fontFamily: 'lexend_regular',
                                fontWeight: FontWeight.w400,
                                color: MyColors.Dark1)),
                          ],
                        ),
                      ),
                      SizedBox(height: 1.h),
                      GestureDetector(
                        onTap: (){
                          launchEmail(aboutUsController.socialResponse.value.data!.contactUs!.value![0].link.toString());
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/sms_notification.svg',width: 3.h,height: 3.h,),
                            SizedBox(width: 1.h),
                            Text(aboutUsController.socialResponse.value.data?.contactUs!.value![0].link.toString()??"", style:  TextStyle(fontSize: 12.sp,
                                fontFamily: 'lexend_regular',
                                fontWeight: FontWeight.w400,
                                color: MyColors.Dark1)),
                          ],
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Text('our_links'.tr(), style:  TextStyle(fontSize: 14.sp,
                          fontFamily: 'lexend_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1)),
                      SizedBox(height: 1.h),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: (){
                                var facebookUrl = aboutUsController.socialResponse.value.data?.socialMediaLinks!.value![0].link.toString();
                                _openUrl(facebookUrl!);
                              },
                              child: SvgPicture.asset('assets/face.svg',width: 7.h,height: 7.h,)),
                          SizedBox(width: 1.h,),
                          GestureDetector(
                              onTap: (){
                                var instagramUrl = 'https://www.instagram.com';
                                _openUrl(instagramUrl);
                              },
                              child: SvgPicture.asset('assets/insta.svg',width: 7.h,height: 7.h,)),
                          SizedBox(width: 1.h,),
                          GestureDetector(
                              onTap: (){
                                var twitterUrl = aboutUsController.socialResponse.value.data?.socialMediaLinks!.value![1].link.toString();
                                _openUrl(twitterUrl!);
                              },
                              child: SvgPicture.asset('assets/twitter.svg',width: 7.h,height: 7.h,)),
                        ],
                      )
                    ],
                  ),
                ),
              )
                  :const Center(child: CircularProgressIndicator(color: MyColors.MainColor),));
            }else{
              return Scaffold(body: NoIntrnet());
            }
          },
          child: const Center(
            child: CircularProgressIndicator(
              color: MyColors.MainColor,
            ),
          )
      )

    );
  }
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void launchEmail(String url) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: url,
    );

    if (await launchUrl(Uri.parse(emailLaunchUri.toString()))) {
    } else {
      throw Exception('Could not launch $emailLaunchUri');
    }
  }

  Future<void> _openUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/no_internet.png'),
          SizedBox(height: 10,),
          Text('there_are_no_internet'.tr(),
            style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

}