import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../conustant/my_colors.dart';
import '../../data/model/priceModel/PriceResponse.dart';

class DropDownPriceItem extends StatelessWidget{
  final Products products;

  DropDownPriceItem({required this.products});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            products.name??"",
            style:  TextStyle(fontSize: 12.sp,
                fontFamily: 'lexend_regular',
                fontWeight: FontWeight.w400,
                color: MyColors.Dark2),
          ),
          Text(
            "${products.regularPrice.toString()??"0.0"} SAR",
            style:  TextStyle(fontSize: 12.sp,
                fontFamily: 'lexend_regular',
                fontWeight: FontWeight.w400,
                color: MyColors.Dark1),
          ),
          Text(
            (products.urgentPrice.toString()??"0.0")+" "+ "EGP",
            style:  TextStyle(fontSize: 12.sp,
                fontFamily: 'lexend_regular',
                fontWeight: FontWeight.w400,
                color: MyColors.Dark1),
          ),
        ],
      ),
    );
  }

}