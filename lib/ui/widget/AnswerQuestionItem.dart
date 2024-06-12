import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../conustant/my_colors.dart';
import '../../data/model/FaqsModel/FaqsResponse.dart';

class AnswerQuestionItem extends StatelessWidget{
  // Faqs faqs;
  var question;
  var answer;
  AnswerQuestionItem({required this.question,required this.answer});

  @override
  build(BuildContext context) {
    return ExpandableNotifier(
      child: Container(
        margin: EdgeInsetsDirectional.all(1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding:  EdgeInsets.all(1.h),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    hasIcon: true,
                    iconPlacement: ExpandablePanelIconPlacement.right,
                    iconColor: Colors.black,
                    collapseIcon: Icons.keyboard_arrow_up_outlined,
                    expandIcon: Icons.keyboard_arrow_down_outlined,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                    padding:  EdgeInsets.all(1.h),
                    child: Row(
                      children: [
                        Text(
                          question??"",
                          style:  TextStyle(fontSize: 14.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark1),
                        ),
                      ],
                    ),
                  ),
                  collapsed: const SizedBox.shrink(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding:  EdgeInsets.only(bottom: 1.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 2,
                                  color: MyColors.BackGroundColor,
                                ),
                                Text(answer??"",style:  TextStyle(fontSize: 12.sp,
                                      fontFamily: 'lexend_regular',
                                      fontWeight: FontWeight.w300,
                                      color: MyColors.Dark3),)
                              ],
                            )
                          //Text(answer!,),
                        ),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding:  EdgeInsets.only(
                        left: 1.h,
                        right: 1.h,
                        bottom: 1.h,
                      ),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}