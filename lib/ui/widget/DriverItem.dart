import 'package:EyaCleanLaundry/conustant/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

class DriverItem extends StatelessWidget{
  bool is_selected;
  GestureTapCallback? onTap;
  DriverItem({required this.is_selected,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsetsDirectional.only(start: 1.5.h,end: 1.5.h,top: 1.5.h,bottom: 1.h),
        padding: EdgeInsetsDirectional.all(1.5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          border: Border.all(color:is_selected?MyColors.MainColor: MyColors.BorderColor,width: 1)
        ),
        child: Row(
          children: [
            Image.asset('assets/driver.png',width: 6.h,),
            SizedBox(width: 1.h,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30.h,
                  child: Row(
                    children: [
                      Text("Zaid Hassan",maxLines: 2,
                        style: TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_medium',
                            fontWeight: FontWeight.w500,
                            color: MyColors.Dark1),
                      ),
                      const Spacer(),
                      Text("4 KM",maxLines: 1,
                        style: TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_medium',
                            fontWeight: FontWeight.w500,
                            color: MyColors.Dark1),
                      ),
                    ],
                  ),
                ),
                Text("4 ${'min_away'.tr()}",
                  style: TextStyle(fontSize: 10.sp,
                      fontFamily: 'lexend_regular',
                      fontWeight: FontWeight.w400,
                      color: MyColors.Dark1),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}