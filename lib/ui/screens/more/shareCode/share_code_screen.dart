import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../business/shareCodeController/ShareCodeController.dart';
import '../../../../conustant/my_colors.dart';
import 'dart:math' as math;

class ShareCodeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ShareCodeScreen();
  }
}

class _ShareCodeScreen extends State<ShareCodeScreen>{
  var code="k85l";
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final shareCodeController = Get.put(ShareCodeController());
  final changeLanguageController = Get.put(ChangeLanguageController());

  @override
  void initState() {
    shareCodeController.getWalletCodeData();
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
              'share_code2'.tr(), style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark1)),
        ),
      ),
      body: Obx(() =>!shareCodeController.isLoading.value?SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin:  EdgeInsetsDirectional.only(top: 5.h,start: 1.5.h,end: 1.5.h),
            child: Column(
              children: [
                SvgPicture.asset('assets/eya_logo.svg'),
                SizedBox(height: 1.h,),
               /* Text('earn'.tr(), style:  TextStyle(fontSize: 14.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w800,
                    color: MyColors.Dark1)),*/
                Text(shareCodeController.walletCodeResponse.value.data?.referralDescription??"", style:  TextStyle(fontSize: 14.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w800,
                    color: MyColors.Dark1),textAlign: TextAlign.center),
                /*SizedBox(height: 1.h,),
                Text('share_code_with_your_friends'.tr(), style:  TextStyle(fontSize: 11.sp,
                    fontFamily: 'lexend_medium',
                    fontWeight: FontWeight.w300,
                    color: MyColors.Dark2),textAlign: TextAlign.center,),*/
                SizedBox(height: 1.h,),
                Text('they_can_use'.tr(), style:  TextStyle(fontSize: 11.sp,
                    fontFamily: 'lexend_medium',
                    fontWeight: FontWeight.w300,
                    color: MyColors.Dark2),textAlign: TextAlign.center),
                _buildCodeItem(shareCodeController.referCode),
                SizedBox(height: 1.h,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 8.h,
                  margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                  padding: EdgeInsetsDirectional.all(1.5.h),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                    //color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('your_current_balance'.tr(), style:  TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_regular',
                          fontWeight: FontWeight.w400,
                          color: MyColors.Dark3),),
                      Text("${(shareCodeController.walletCodeResponse.value.data!.walletBalance??"")}${'egp'.tr()}", style:  TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_bold',
                          fontWeight: FontWeight.w700,
                          color: MyColors.Dark1),),
                    ],
                  ),
                ),
                SizedBox(height: 1.h,),
                /*Container(
                width: MediaQuery.of(context).size.width,
                height: 8.h,
                margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                padding: EdgeInsetsDirectional.all(1.5.h),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: MyColors.Dark5, width: 1.0,),
                  //color: Colors.white
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('remaining_invitations'.tr(), style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w400,
                        color: MyColors.Dark3),),
                    Text("4", style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w700,
                        color: MyColors.Dark1),),
                  ],
                ),
              )*/
              ],
            ),
          )
      )
          :const Center(child: CircularProgressIndicator(color: MyColors.MainColor),))
    );
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

  _buildCodeItem(String value) {
    return Container(
      width: Size.infinite.width,
      margin:  EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.5.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: DottedBorder(
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        color: MyColors.MainColor,
        dashPattern: const [5, 4, 5, 4],
        strokeWidth: 1,
        radius: const Radius.circular(12),
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 2.h),
          child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 1.5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style:  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: MyColors.Dark1,
                        letterSpacing: 8.0),
                  ),
                  TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      Share.share(value);
                    },
                    child: Text('share'.tr(),
                        style:  TextStyle(
                            fontSize: 12.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                ],
              )),
        ),
      ),
    );
  }

}