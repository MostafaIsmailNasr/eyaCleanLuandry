import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/createOrderController/CreateOrderController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../conustant/toast_class.dart';

class ChoosePyment extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChoosePyment();
  }
}

class _ChoosePyment extends State<ChoosePyment>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final createOrderController = Get.put(CreateOrderController());
  var isSelected=false;
  int? itemId=0;
  var payment="";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: 2.h,left: 2.h,top: 1.h,bottom: 1.h),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBar(),
              InkWell(
                onTap: (){
                  setState(() {
                    isSelected=true;
                    itemId=1;
                    createOrderController.payment.value="cash";
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 7.h,
                  margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                  padding:  EdgeInsets.all(1.h),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/cach.svg',width: 6.h,height: 6.h,),
                       SizedBox(width: 1.h,),
                      Text('cash_on_delivery'.tr(),
                        style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color: MyColors.Dark2),),
                      const Spacer(),
                      isSelected==true && itemId==1?SvgPicture.asset('assets/checked.svg'):SvgPicture.asset('assets/rado_unChecked.svg'),
                    ],
                  ),
                ),
              ),
              Container(
                  margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                  child: SvgPicture.asset('assets/separator.svg')),
               SizedBox(height: 0.2.h,),
              InkWell(
                onTap: (){
                  setState(() {
                    isSelected=true;
                    itemId=2;
                    createOrderController.payment.value="tabby";
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 7.h,
                  margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                  padding:  EdgeInsets.all(1.h),
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/tabby.svg',width: 6.h,height: 6.h,),
                       SizedBox(width: 1.h,),
                      Text('credit_card'.tr(),
                        style: TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color: MyColors.Dark2),),
                      const Spacer(),
                      isSelected==true && itemId==2?SvgPicture.asset('assets/checked.svg'):SvgPicture.asset('assets/rado_unChecked.svg'),
                    ],
                  ),
                ),
              ),
              Container(
                  margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                  child: SvgPicture.asset('assets/separator.svg')),
              SizedBox(height: 0.2.h,),
              InkWell(
                onTap: (){
                  setState(() {
                    isSelected=true;
                    itemId=3;
                    createOrderController.payment.value="noon";
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 7.h,
                  margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                  padding:  EdgeInsets.all(1.h),
                  child: Row(
                    children: [
                      Container(
                          margin: EdgeInsetsDirectional.only(start: 1.5.h),
                          child: Image.network("https://eyacleanproksa.com/assets/images/card.png",width: 20.h,)),
                      // SvgPicture.asset('assets/noon.svg',width: 6.h,height: 6.h,),
                      // SizedBox(width: 1.h,),
                      // Text('wallet'.tr(),
                      //   style: TextStyle(fontSize: 12.sp,
                      //       fontFamily: 'lexend_regular',
                      //       fontWeight: FontWeight.w400,
                      //       color: MyColors.Dark2),),
                      const Spacer(),
                      isSelected==true && itemId==3?SvgPicture.asset('assets/checked.svg'):SvgPicture.asset('assets/rado_unChecked.svg'),
                    ],
                  ),
                ),
              ),
               SizedBox(height: 2.h,),
              Container(
                margin: EdgeInsets.only(left: 2.h, right: 2.h),
                width: double.infinity,
                height: 8.h,
                child: TextButton(
                  style: flatButtonStyle,
                  onPressed: () {
                    if(isSelected!=false){
                      Navigator.pop(context);
                    }else{
                      ToastClass.showCustomToast(context, 'please_choose_lang'.tr(), 'error');
                    }
                  },
                  child: Text('keep_going'.tr(),
                    style: TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w700,
                        color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomBar(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 3.h,),
        Container(
          height: 4.h,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Text('payment_method'.tr(),
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w700,
                    color: MyColors.Dark1),
              ),
              Spacer(),
              IconButton(iconSize: 3.h,
                  icon: Icon(Icons.close),
                  color: MyColors.Dark3,
                  onPressed:(){
                    createOrderController.payment.value="";
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}