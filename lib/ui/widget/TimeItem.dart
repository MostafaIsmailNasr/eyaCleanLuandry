import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../conustant/my_colors.dart';
import '../../data/model/hoursModel/HoursResponse.dart';

class TimeItem extends StatelessWidget{
  bool is_selected;
  GestureTapCallback? onTap;
  Hours hours;
  TimeItem({required this.is_selected,required this.onTap,required this.hours});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        // margin: EdgeInsetsDirectional.only(end: 8,bottom: 8),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: MyColors.Dark5, width:1.0,),
          color: is_selected?MyColors.MainColor2: Colors.white,
          // // Apply disable styles if the item is disabled
          // boxShadow: hours.isAvailable==false?
          // [
          //   BoxShadow(
          //     color: Colors.grey.withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: Offset(0, 3),
          //   ),
          // ] : null,
        ),
        child: Center(
          child:  Text(hours.time??"",
            style: TextStyle(fontSize: 12.sp,
                fontFamily: 'lexend_regular',
                decoration: hours.isAvailable==true?TextDecoration.none:TextDecoration.lineThrough,
                fontWeight: FontWeight.w400,
                color:is_selected?Colors.white: MyColors.Dark2),
          ),
        ),
      ),
    );
  }

}