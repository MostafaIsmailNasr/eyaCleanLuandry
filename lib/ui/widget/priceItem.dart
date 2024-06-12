import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../conustant/my_colors.dart';
import '../../data/model/priceModel/PriceResponse.dart';
import 'dropDownPriceItem.dart';


class PriceItem extends StatelessWidget {
  final SubCategories? subCategories;

  const PriceItem({Key? key,this.subCategories}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Container(
        margin: EdgeInsetsDirectional.all(1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: MyColors.BorderColor,width: 1)
        ),
        child: Padding(
          padding:  EdgeInsets.all(1.5.h),
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
                    padding:  EdgeInsets.all(2.h),
                    child: Row(
                      children: [
                        Text(
                          subCategories!.name??"",
                          style:  TextStyle(fontSize: 13.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark1),
                        ),
                        Spacer(),
                        Text(
                          'price'.tr()+" ",
                          style:  TextStyle(fontSize: 11.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark1),
                        ),
                        // Text(
                        //   'per_price'.tr(),
                        //   style:  TextStyle(fontSize: 9.sp,
                        //       fontFamily: 'lexend_regular',
                        //       fontWeight: FontWeight.w400,
                        //       color: MyColors.Dark3),
                        // ),
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
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 0.2.h,
                                color: MyColors.BackGroundColor,
                              ),
                              SizedBox(height: 1.h,),
                              priceType(),
                              priceeList(),
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
  Widget priceeList(){
    return Container(
      margin: EdgeInsetsDirectional.all( 2.h),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: subCategories!.products!.length,
          itemBuilder: (context,int index){
            return DropDownPriceItem(
               products: subCategories!.products![index]
            );
          }
      ),
    );
  }
  Widget priceType(){
    return Container(
      margin: EdgeInsetsDirectional.only(end: 1.5.h,start: 1.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15.h,
            child: Text(
              "price2".tr(),
              style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_regular',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark2),
            ),
          ),
          Text(
            "normal".tr(),
            style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'lexend_regular',
                fontWeight: FontWeight.w400,
                color: MyColors.SecondryColor),
          ),
          Text(
            "urgent".tr(),
            style: TextStyle(
                fontSize: 12.sp,
                fontFamily: 'lexend_regular',
                fontWeight: FontWeight.w400,
                color: Colors.green),
          ),
        ],
      ),
    );
  }
}