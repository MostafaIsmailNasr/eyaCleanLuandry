import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/my_colors.dart';

class SuccessDialogScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _SuccessDialogScreen();
  }
}

class _SuccessDialogScreen extends State<SuccessDialogScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin:  EdgeInsetsDirectional.only(start: 2.h,end: 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/success2.png'),
                 SizedBox(height: 1.h,),
                Text(
                    'congratulations'.tr(), style:  TextStyle(fontSize: 16.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w800,
                    color: MyColors.Dark1)),
                 SizedBox(height: 1.h,),
                Text(
                    'your_phone_number_has_been_successfully_changed'.tr(), style:  TextStyle(fontSize: 11.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w300,
                    color: MyColors.Dark3),textAlign: TextAlign.center,),
                 SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'old_number'.tr(), style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w400,
                        color: MyColors.Dark3)),
                     SizedBox(height: 1.h,),
                    Text(
                        "01152514885", style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w400,
                        color: MyColors.Dark1)),
                  ],
                ),
                 SizedBox(height: 1.5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'new_number'.tr(), style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w400,
                        color: MyColors.Dark3)),
                    Text(
                        "01152514885", style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w400,
                        color: MyColors.Dark1)),
                  ],
                ),
                 SizedBox(height: 1.h,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 8.h,
                  child: TextButton(
                    style: flatButtonStyle ,
                    onPressed: (){
                      Navigator.pushNamed(context, '/drower');
                    },
                    child: Text('home'.tr(),
                        style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}