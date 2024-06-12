import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/my_colors.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../business/notificationController/NotificationController.dart';
import '../../widget/NotificationItem.dart';
import 'dart:math' as math;


class NotificationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _NotificationScreen();
  }
}

class _NotificationScreen extends State<NotificationScreen> {
  final notificationController = Get.put(NotificationController());
  final changeLanguageController = Get.put(ChangeLanguageController());

  @override
  void initState() {
    notificationController.getNotificationData();
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
              child: SvgPicture.asset('assets/back.svg',))),
          title: Center(
            child: Text('notification'.tr(),
                style: TextStyle(
                    fontSize: 14.sp,
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
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  margin:
                      EdgeInsets.only(left: 1.5.h, right: 1.5.h, top: 1.5.h),
                  child: Obx(() => !notificationController.isLoading.value
                      ? NotificationList()
                      : const Center(
                          child: CircularProgressIndicator(
                          color: MyColors.MainColor,
                        ))),
                );
              } else {
                return Scaffold(body: NoIntrnet());
              }
            },
            child: const Center(
              child: CircularProgressIndicator(
                color: MyColors.MainColor,
              ),
            )));
  }

  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/no_internet.png'),
          SizedBox(height: 1.h,),
          Text('there_are_no_internet'.tr(),
            style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

  Widget NotificationList() {
    if (notificationController.notificationList.isNotEmpty){
      return ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: notificationController.notificationList.length,
          itemBuilder: (context, int index) {
            return NotificationItem(
                notification: notificationController.notificationList[index]
            );
          }
      );
  } else{
      return empty();
    }
  }
}

class empty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 15.h),
      child: Center(
        child: Column(
          children: [
            //Image(image: AssetImage('assets/offers_empty.png')),
            SvgPicture.asset('assets/no_notifactions.svg'),
            SizedBox(height: 1.h,),
            Text('there_are_no_notification'.tr(),
              style: TextStyle(fontSize: 14.sp,
                  fontFamily: 'lexend_bold',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h,),
            Text('your_notifications_will_appear_here'.tr(),
              style: TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_bold',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}