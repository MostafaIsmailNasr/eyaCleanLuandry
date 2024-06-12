import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../conustant/my_colors.dart';

class TermsAndContitionItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 1.h,
            height: 1.h,
            decoration: BoxDecoration(
              color: MyColors.Dark1,
              shape: BoxShape.circle,
            ),
            margin:  EdgeInsets.only(right: 1.h),
          ),
          Flexible(
            child: Text(
              "This text can be installed on any design without a problem, it will not look like copied, unorganized, unformatted, or even This text can be installed on any design without a problem",
              style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_regular',
                  fontWeight: FontWeight.w300,
                  color: MyColors.Dark2),
              maxLines: 10,
            ),
          ),
        ],
      ),
    );
  }

}