import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';

import '../../business/addressListController/AddressListController.dart';
import '../../conustant/my_colors.dart';
import '../../data/model/addressModel/addressListModel/AddressListResponse.dart';
import '../screens/deleteDialog/DeleteScreen.dart';
import '../screens/more/myLocation/editeLocation/edit_location_screen.dart';

class MyAddressItem extends StatelessWidget{
  final Address address;
  final addressListController = Get.put(AddressListController());
  MyAddressItem({required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsetsDirectional.only(bottom: 1.h),
      decoration:  BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: Colors.white,
      border: Border.all(color: MyColors.BorderColor)),
      child: Padding(
        padding:  EdgeInsets.all(1.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(addressListController.userName??"",
                  style:  TextStyle(fontSize: 14.sp,
                      fontFamily: 'lexend_regular',
                      fontWeight: FontWeight.w400,
                      color: MyColors.Dark1),
                ),
                 SizedBox(width: 1.h,),
                Container(
                  width: 7.h,
                  height: 3.h,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: MyColors.MainColor2, width: 1.0,),
                      color: MyColors.MainColor2),
                  child: Center(
                    child: Text(address.type??"",
                      style:  TextStyle(fontSize: 8.sp,
                          fontFamily: 'lexend_light',
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  EditLocationScreen(
                          latedit: address.lat,lngedit: address.lng,addressEdit: address.streetName,
                            id:address.id,typeEd:address.type
                        )),
                      );
                    },
                    child: SvgPicture.asset('assets/edit2.svg',width: 5.h,height: 5.h,)),
                const SizedBox(width: 5,),
                GestureDetector(
                    onTap: (){
                      //_onAlertButtonsPressed(context);
                      showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor:MyColors.BackGroundColor,
                          builder: (BuildContext context)=> Padding(
                              padding: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: DeleteScreen(id: address!.id!,)
                          )
                      );
                    },
                    child: SvgPicture.asset('assets/delete2.svg',width: 5.h,height: 5.h))
              ],
            ),
            //const SizedBox(height: 8,),
            Text(address.streetName??"",
              style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_regular',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark3),
            ),
             SizedBox(height: 1.h,),
            // Text("nasr city , cairo ,egypt",
            //   style:  TextStyle(fontSize: 12.sp,
            //       fontFamily: 'lexend_regular',
            //       fontWeight: FontWeight.w400,
            //       color: MyColors.Dark3),
            // ),
          ],
        ),
      ),
    );
  }


  _onAlertButtonsPressed(context) {
    Alert(
      context: context,
      image: SvgPicture.asset('assets/delete2.svg',width: 100,height: 100,),
      title: 'delete_location'.tr(),
      style:  AlertStyle(
          titleStyle:TextStyle(fontSize: 16.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w800,
              color: MyColors.Dark1),
          descStyle: TextStyle(fontSize: 10.sp,
              fontFamily: 'lexend_regular',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark2),
        backgroundColor: Colors.white
      ),
      desc: 'are_you_sure_you_want_to_delete_location'.tr(),
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(50),
          height: 7.h,
          child: Text('delete'.tr(), style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white)),
          onPressed: () => {
          },
          color: MyColors.SecondryColor,
        ),
        DialogButton(
          height: 7.h,
          radius: BorderRadius.circular(50),
          child: Text('cancel'.tr(), style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white)),
          onPressed: () {
            Navigator.pop(context);
          },
          color: MyColors.MainColor,

        )
      ],
    ).show();
  }

}