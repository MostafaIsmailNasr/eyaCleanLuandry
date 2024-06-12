import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/toast_class.dart';

import '../../../../business/createOrderController/CreateOrderController.dart';
import '../../../../conustant/di.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../conustant/shared_preference_serv.dart';
import '../../../widget/OfferHomeItem.dart';
import '../../../widget/PromotionalItem.dart';

class AddPromotionalCode extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddPromotionalCode();
  }
}

class _AddPromotionalCode extends State<AddPromotionalCode>{
  final _formKey = GlobalKey<FormState>();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final createOrderController = Get.put(CreateOrderController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(right: 2.h,left: 2.h,top: 1.h,bottom: 1.h),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomBar(),
                 SizedBox(height: 1.h,),
                enterCode(),
                 SizedBox(height: 1.h,),
                /*Center(
                  child: Obx(() =>
                      Visibility(
                          visible: createOrderController.isVisable
                              .value,
                          child: const CircularProgressIndicator(color: MyColors.MainColor,)
                      )),
                ),*/
              ],
            ),
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
              Text('Add_promotional_code'.tr(),
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
                    Navigator.pop(context);
                  }
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h,),
      ],
    );
  }

  Widget enterCode(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 8.h,
      child: Row(
        children: [
          code(),
          const Spacer(),
          Obx(() =>
              Visibility(
                  visible: createOrderController.isVisable.value,
                  child: const CircularProgressIndicator(color: MyColors.MainColor,)
              )),
        Obx(() =>   createOrderController.isVisable.value==true?
          Container()
              :SizedBox(
            width: 12.h,
            height: 6.h,
            child: TextButton(
              style: flatButtonStyle,
              onPressed: () {
                if(_formKey.currentState!.validate()){
                  createOrderController.isVisable.value=true;
                  createOrderController.validateCopune(context);
                }
              },
              child: Text('apply'.tr(),
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w700,
                    color: Colors.white),),
            ),
          ))
        ],
      ),
    );
  }

  Widget code (){
    return Container(
      width: 30.h,
      child: TextFormField(
        autovalidateMode:AutovalidateMode.onUserInteraction ,
        controller: createOrderController.codeController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please_enter_code'.tr();
          }
          return null;
        },
        maxLines: 1,
        decoration: InputDecoration(
          errorBorder:  const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: MyColors.Dark5,style: BorderStyle.solid),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(style: BorderStyle.solid,color: MyColors.Dark3,)
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
          ) ,
          hintText: 'Promotional_code'.tr(),
          hintStyle:  TextStyle(fontSize: 11.sp,
              fontFamily: 'lexend_regular',
              fontWeight: FontWeight.w300,
              color: MyColors.Dark3),
        ),
        style:  TextStyle(fontSize: 11.sp,
            fontFamily: 'lexend_regular',
            fontWeight: FontWeight.w300,
            color: MyColors.Dark3),
      ),
    );
  }

  /*Widget offerList() {
    return Container(
      height: 35.h,
      margin: EdgeInsetsDirectional.only(bottom: 1.h),
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 2,
          itemBuilder: (context,int index){
            return PromotionalItem();
          }
      ),
    );
  }*/
}