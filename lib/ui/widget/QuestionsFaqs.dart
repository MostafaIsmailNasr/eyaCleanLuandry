import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../conustant/my_colors.dart';
import '../../data/model/FaqsModel/FaqsResponse.dart';

class QuestionsFaqs extends StatelessWidget{
  bool is_selected;
  GestureTapCallback? onTap;
  AllFaqs allFaqs;

  QuestionsFaqs({required this.is_selected,required this.onTap,required this.allFaqs});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: MyColors.Dark5,
              width: 1,
            ),
            color:is_selected? MyColors.MainColor:Colors.white
        ),
        child:  Padding(
          padding: EdgeInsets.all(5),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(allFaqs.name??"",
              style: TextStyle(fontSize: 12.sp,
                fontFamily: 'lexend_regular',
                fontWeight: FontWeight.w400,
                color:is_selected? Colors.white:MyColors.Dark3),textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }

}