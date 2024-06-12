import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/addressListController/AddressListController.dart';
import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget/MyAddressItem.dart';
import 'dart:math' as math;

class MyAddressScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAddressScreen();
  }
}

class _MyAddressScreen extends State<MyAddressScreen> {
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final addressListController = Get.put(AddressListController());
  final changeLanguageController = Get.put(ChangeLanguageController());

  @override
  void initState() {
    addressListController.getAddressList();
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
              'my_locations'.tr(), style:  TextStyle(fontSize: 14.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark1)),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin:  EdgeInsetsDirectional.only(top: 1.5.h,start: 1.5.h,end: 1.5.h),
        child: Obx(() => !addressListController.isLoading.value? addressList()
            :const Center(child: CircularProgressIndicator(color: MyColors.MainColor,),)),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsetsDirectional.only(end: 15,start: 15,bottom: 15),
        height: 8.h,
        child: TextButton(
          style: flatButtonStyle,
          onPressed: () {
            Navigator.pushNamed(context, '/location_screen',arguments: "listAddress");
          },
          child: Text('add_new_location'.tr(),
              style:  TextStyle(
                  fontSize: 12.sp,
                  fontFamily: 'lexend_regular',
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
        ),
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
          SizedBox(height: 10,),
          Text('there_are_no_internet'.tr(),
            style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

  Widget addressList() {
    if(addressListController.addressList.isNotEmpty){
      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: addressListController.addressList.length,
          itemBuilder: (context, int index) {
            return MyAddressItem(
              address: addressListController.addressList[index],
            );
          }
      );
    }else{
      return empty();
    }
  }
}

class empty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 60),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/no_locations.svg'),
            SizedBox(height: 10,),
            Text('there_are_no_address'.tr(),
              style: TextStyle(fontSize: 14.sp,
                  fontFamily: 'lexend_bold',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text('there_are_no_address'.tr(),
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