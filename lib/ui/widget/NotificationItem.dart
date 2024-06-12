import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/my_colors.dart';

import '../../data/model/notificationModel/NotificationResponse.dart';

class NotificationItem extends StatelessWidget{
  final Notifi? notification;

  NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(1.h),
      margin: EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        border: Border.all(width: 1,color: MyColors.BorderColor)
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/message.svg',width: 7.h,height: 7.h,),
          Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // SizedBox(height: 1.h,),
                  // Text("Confirmation of receipt",maxLines: 2,
                  //   style: TextStyle(fontSize: 12.sp,
                  //     fontFamily: 'lexend_regular',
                  //     fontWeight: FontWeight.w400,
                  //     color: MyColors.Dark1),
                  // ),
                  SizedBox(height: 1.h,),
                  Text(notification!.data??"",maxLines: 4,
                    style: TextStyle(fontSize: 11.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w300,
                        color: MyColors.Dark3),
                  ),
                  SizedBox(height: 1.h,),
                  Text(notification!.createdAt??"",maxLines: 1,
                    style: TextStyle(fontSize: 10.sp,
                        fontFamily: 'lexend_light',
                        fontWeight: FontWeight.w300,
                        color: MyColors.Dark3),
                  ),
                ],
              )
          ),
        ],
      ),
    );
  }

}