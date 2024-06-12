import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../conustant/my_colors.dart';
import '../../data/model/walletModel/WalletResponse.dart';

class WalletItem extends StatelessWidget{
  WalletTransactions walletTransactions;

  WalletItem({required this.walletTransactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12.h,
      width: MediaQuery.of(context).size.width,
      padding:  EdgeInsets.all(1.h),
      margin:  EdgeInsets.only(bottom: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: MyColors.BorderColor,width: 1)
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/doller.svg',width: 7.h,height: 7.h,),
           SizedBox(width: 1.h,),
           Column(
             mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(walletTransactions.userName??"",maxLines: 2,
                style:TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_medium',
                    fontWeight: FontWeight.w500,
                    color: MyColors.Dark1),
              ),
               SizedBox(height: 0.5.h,),
              Text(walletTransactions.createdAt??"",maxLines: 2,
                style:TextStyle(fontSize: 10.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark3),
              ),
            ],
          ),
          const Spacer(),
          Text(walletTransactions.currentBalance.toString()+'egp'.tr(),
            style:TextStyle(fontSize: 12.sp,
                fontFamily: 'lexend_medium',
                fontWeight: FontWeight.w500,
                color: MyColors.MainColor),
          ),
        ],
      ),
    );
  }

}