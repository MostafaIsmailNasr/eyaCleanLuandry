import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../conustant/my_colors.dart';
import '../../data/model/ListOrderModel/ListOrderResponse.dart';

class DropDownDetaildItem extends StatelessWidget{
  OrderItems orderItems;

  DropDownDetaildItem({required this.orderItems});

  @override
  Widget build(BuildContext context) {
    return   Container(
      margin:  EdgeInsetsDirectional.only(bottom: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 6.h,
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image:  DecorationImage(image: NetworkImage(orderItems.productImage??""),fit: BoxFit.fill),
            ),
          ),
          //Image(image: NetworkImage(orderItems.productImage??""),width: 6.h,height: 6.h,),
          SizedBox(width: 2.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orderItems.productName??"",style:  TextStyle(
                fontSize: 10.sp,
                fontFamily: 'lexend_regular',
                fontWeight: FontWeight.w400,
                color: MyColors.Dark3,
              ),),
              Row(
                children: [
                  Text('Quantity'.tr(),style:  TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2,
                  ),),
                  Text(orderItems.quantity.toString()??"",style:  TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2,
                  ),),
                ],
              ),
            ],
          ),
          const Spacer(),
          Container(
            margin: EdgeInsetsDirectional.symmetric(vertical: 5),
            child: Text("${orderItems.price??""} SAR",style:  TextStyle(
              fontSize: 12.sp,
              fontFamily: 'lexend_regular',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark1,
            ),),
          )
        ],
      ),
    );
  }

}