import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import '../../conustant/my_colors.dart';
import '../screens/buttomSheets/orderTypeBottomSheet/choose_order_type.dart';

class PromotionalItem extends StatelessWidget{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));

  @override
  Widget build(BuildContext context) {
    return Container(
      width:70.w,
      margin: EdgeInsetsDirectional.only(start: 1.h,end: 1.h,bottom: 2.h),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.white, width: 1.0,),
          color:  Colors.white),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image(image: AssetImage('assets/clothes.png'),width:from=="promotional"?500: 40.h,fit: BoxFit.fill,),
            Image(image: AssetImage('assets/clothes.png'),fit: BoxFit.fill,width: MediaQuery.of(context).size.width,),
            SizedBox(height: 1.h,),
            Container(
              // width: 300,
              padding: EdgeInsets.only(right: 1.h,left: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('work_week'.tr(),
                    style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w700,
                        color: MyColors.Dark1),),
                  Text("150"+" "+'egp'.tr(),
                    style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w700,
                        color: MyColors.SecondryColor),),
                ],
              ),
            ),
            SizedBox(height: 1.h,),
            Container(
                padding: EdgeInsets.only(right: 1.h,left: 1.h),
                // width: 30.h,
                child: Text("Get readydsfgddddddddddddddddddddddddddddddddddddddddddddddddddddd",style:
                TextStyle(fontSize: 8.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w700,
                    color: MyColors.Dark2))),
            SizedBox(height: 1.h,),
            Container(
              // width: 40.h,
              padding: EdgeInsets.only(right: 1.h,left: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Promotional_code'.tr(),
                    style:  TextStyle(fontSize: 10.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w400,
                        color: MyColors.Dark3),),
                  Text("C8AWL",
                    style:  TextStyle(fontSize: 10.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w500,
                        color: MyColors.Dark1),),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 6.h,
              margin: EdgeInsetsDirectional.only(start: 1.h,end: 1.h,top: 1.h),
              child: TextButton(
                style: flatButtonStyle,
                onPressed: () {
                },
                child: Text('get_offer_now'.tr(),
                  style:  TextStyle(fontSize: 10.sp,
                      fontFamily: 'lexend_bold',
                      fontWeight: FontWeight.w400,
                      color: Colors.white),),
              ),
            )
          ]),

    );
  }

}