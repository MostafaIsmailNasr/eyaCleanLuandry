import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../business/listOrderController/ListOrderController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../conustant/toast_class.dart';
import 'dart:math' as math;

class RateOrderScreen extends StatefulWidget{
  int id;

  RateOrderScreen({required this.id});
  @override
  State<StatefulWidget> createState() {
   return _RateOrderScreen();
  }
}

class _RateOrderScreen extends State<RateOrderScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final listOrdersController = Get.put(ListOrdersController());
  final changeLanguageController = Get.put(ChangeLanguageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: MyColors.BackGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              listOrdersController.NotesController.clear();
              listOrdersController.orderRate=0.0;
              listOrdersController.driverRate=0.0;
              Navigator.pop(context);
            },
            icon: Transform.rotate(
                angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
                child: SvgPicture.asset('assets/back.svg',))
        ),
        title: Center(
          child: Text(
              'rating'.tr(), style:  TextStyle(fontSize: 14.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark1)),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsetsDirectional.only(start: 1.5.h,end: 1.5.h,top: 3.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: SvgPicture.asset('assets/rate.svg')),
              SizedBox(height: 2.h,),
              Text(
                  'how_was_your_order_experience'.tr(), style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2)),
              SizedBox(height: 1.h,),
              RatingBar.builder(
                initialRating:listOrdersController.orderRate!,
                itemSize: 30,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding:
                const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: MyColors.MainColor2,
                ),
                onRatingUpdate: (rating) {
                  log(rating.toString());
                  listOrdersController.orderRate=rating;
                },
              ),
              SizedBox(height: 2.h,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 15.h,
                padding:  EdgeInsets.only(left: 1.h, right: 1.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: MyColors.Dark5)),
                child: note(),
              ),
              SizedBox(height: 3.h,),
              Text(
                  'driver_rating'.tr(), style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_medium',
                  fontWeight: FontWeight.w500,
                  color: MyColors.Dark2)),
              SizedBox(height: 1.h,),
              RatingBar.builder(
                initialRating:listOrdersController.driverRate!,
                itemSize: 30,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding:
                const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: MyColors.MainColor2,
                ),
                onRatingUpdate: (rating) {
                  log(rating.toString());
                  listOrdersController.driverRate=rating;
                },
              ),
              SizedBox(height: 2.h,),
              Center(
                child: Obx(() =>
                    Visibility(
                        visible: listOrdersController.isVisable
                            .value,
                        child: const CircularProgressIndicator(color: MyColors.MainColor,)
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 8.h,
                child: TextButton(
                  style: flatButtonStyle ,
                  onPressed: (){
                    if(listOrdersController.orderRate==0.0){
                      ToastClass.showCustomToast(context,"Please Enter Rate", 'error');
                    }else{
                      listOrdersController.isVisable.value=true;
                      listOrdersController.RateOrder(widget.id,context);
                    }
                  },
                  child: Text('confirm'.tr(),
                    style: TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w700,
                        color: Colors.white),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget note (){
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      controller: listOrdersController.NotesController,
      maxLines: 3,
      decoration: InputDecoration(
          errorBorder:  const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide(style: BorderStyle.solid,color: Colors.white70,)
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
          ) ,
          hintText:'add_notes_here'.tr(),
          hintStyle:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark3)
      ),
      style:  TextStyle(fontSize: 12.sp,
          fontFamily: 'lexend_regular',
          fontWeight: FontWeight.w300,
          color: MyColors.Dark3),
    );
  }

}