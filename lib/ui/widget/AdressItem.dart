import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:sizer/sizer.dart';

import '../../business/addressListController/AddressListController.dart';
import '../../conustant/my_colors.dart';
import '../../data/model/addressModel/addressListModel/AddressListResponse.dart';

class AddressItem extends StatelessWidget{
  bool is_selected;
  GestureTapCallback? onTap;
  final Address address;
  final addressListController = Get.put(AddressListController());
  AddressItem({required this.is_selected,required this.onTap,required this.address});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsetsDirectional.only(bottom: 1.h),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color:is_selected?MyColors.MainColor2: MyColors.Dark5, width: 2.0,),
            color: Colors.white),
        child: Padding(
          padding:  EdgeInsets.all(1.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(addressListController.userName??"",
                    style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w400,
                        color: MyColors.Dark1),
                  ),
                  Container(
                    width: 9.h,
                    height: 4.h,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: MyColors.MainColor2, width: 1.0,),
                        color: MyColors.MainColor2),
                    child: Center(
                      child: Text(address.type??"",
                        style:  TextStyle(fontSize: 10.sp,
                            fontFamily: 'lexend_light',
                            fontWeight: FontWeight.w300,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
               SizedBox(height: 1.h,),
              Text(address.streetName??"",
                style:  TextStyle(fontSize: 11.sp,
                    fontFamily: 'lexend_light',
                    fontWeight: FontWeight.w300,
                    color: MyColors.Dark3),
              ),
               SizedBox(height: 1.h,),
              // Text("nasr city , cairo ,egypt",
              //   style:  TextStyle(fontSize: 11.sp,
              //       fontFamily: 'lexend_light',
              //       fontWeight: FontWeight.w300,
              //       color: MyColors.Dark3),
              // ),
            ],
          ),
        ),
      ),
    );
  }


}