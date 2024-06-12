import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../business/walletBalanceController/WalletBalanceController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget/walletItem.dart';
import 'dart:math' as math;

class WalletScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _WalletScreen();
  }
}

class _WalletScreen extends State<WalletScreen>{
  final walletBalanceController = Get.put(WalletBalanceController());
  final changeLanguageController = Get.put(ChangeLanguageController());

  @override
  void initState() {
    walletBalanceController.getWalletData();
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
                child: SvgPicture.asset('assets/back.svg'))
        ),
        title: Center(
          child: Text(
              'my_wallet'.tr(), style:  TextStyle(fontSize: 14.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark1)),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin:  EdgeInsetsDirectional.only(end: 2.h,start: 2.h,top: 2.h),
        child: Obx(() =>!walletBalanceController.isLoading.value? offerList():
        const Center(child: CircularProgressIndicator(color: MyColors.MainColor),)),
      ),

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

  Widget offerList() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 15.h,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: MyColors.MainColor, width: 1.0,),
                color:  MyColors.MainColor),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/wallet2.svg'),
                 SizedBox(width: 2.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('your_current_balance'.tr(),
                    style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_semiBold',
                        fontWeight: FontWeight.w500,
                        color:Colors.white),),
                    Text("${walletBalanceController.walletResponse.value.data!.walletBalance??""} ${'egp'.tr()}",
                      style:  TextStyle(fontSize: 22.sp,
                          fontFamily: 'lexend_regular',
                          fontWeight: FontWeight.w800,
                          color:Colors.white),),
                  ],
                )
              ],
            ),
          ),
           SizedBox(height: 2.h),
          Text('latest_operations'.tr(),
            style:TextStyle(fontSize: 12.sp,
                fontFamily: 'lexend_medium',
                fontWeight: FontWeight.w400,
                color: MyColors.Dark1),
          ),
          SizedBox(height: 1.h),
          ListView.builder(
            physics:const NeverScrollableScrollPhysics() ,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: walletBalanceController.walletList.length,
              itemBuilder: (context, int index) {
                return WalletItem(
                    walletTransactions: walletBalanceController.walletList[index],
                );
              }),
        ],
      ),
    );
  }
}