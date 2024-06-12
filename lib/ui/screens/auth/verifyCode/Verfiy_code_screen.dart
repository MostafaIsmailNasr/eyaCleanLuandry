import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/toast_class.dart';

import '../../../../business/auth/verifyController/VerifyController.dart';
import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../conustant/di.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../conustant/shared_preference_serv.dart';
import 'dart:math' as math;

class VerfiyCodeScreen extends StatefulWidget{
  var code;
  VerfiyCodeScreen({required this.code});

  @override
  State<StatefulWidget> createState() {
    return _VerfiyCodeScreen();
  }
}

class _VerfiyCodeScreen extends State<VerfiyCodeScreen>{
  final _verifyformKey = GlobalKey<FormState>();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final verifyController = Get.put(VerifyController());
  final changeLanguageController = Get.put(ChangeLanguageController());
  TextEditingController verfiyCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print(widget.code.toString());
    Fluttertoast.showToast(
      msg: widget.code.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
    );
    verifyController.getphone();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:MyColors.BackGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Transform.rotate(
                angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
                child: SvgPicture.asset('assets/back.svg',))
      ),
    ),
      body: Form(
        key: _verifyformKey,
        child: Container(
            margin:  EdgeInsetsDirectional.only(start: 2.5.h, end: 2.5.h),
            child: Center(
                child: SingleChildScrollView(
                  child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 20.h,child: Image.asset('assets/otp.png')),
                           SizedBox(height: 1.5.h),
                          Text('verify_phone'.tr(), style:  TextStyle(fontSize: 16.sp,
                              fontFamily: 'lexend_bold',
                              fontWeight: FontWeight.w800,
                              color: MyColors.Dark1)),
                          Text('code_send'.tr()+verifyController.phone.toString(), style:  TextStyle(fontSize: 12.sp,
                              fontFamily: 'lexend_medium',
                              fontWeight: FontWeight.w300,
                              color: MyColors.Dark3)),
                           SizedBox(height: 3.h,),
                          PinCodeTextField(
                            appContext: context,
                            controller: verfiyCodeController,
                            length: 4, // Set the length of the PIN code
                            onChanged: (pin) {
                              setState(() {
                                verifyController.currentPin = pin;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please_enter_verify_code'.tr();
                              }else if(value.length<4){
                                return 'code_must'.tr();
                              }
                              return null;
                            },
                            // controller: verifyController.verfiyCodeController,
                            pinTheme: PinTheme(
                              selectedFillColor:Colors.white,
                              inactiveFillColor: Colors.white,
                              activeFillColor: Colors.white,
                              activeColor:MyColors.BorderColor,
                              inactiveColor: MyColors.BorderColor,
                              shape: PinCodeFieldShape.circle,
                              fieldHeight: 10.h,
                              fieldWidth: 15.w,
                            ),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.number,
                            textStyle:  TextStyle(fontSize: 11.sp,color: MyColors.Dark3),
                            onCompleted: (pin) {
                              verifyController.verify(context,verifyController.currentPin);
                              verfiyCodeController.clear();
                            },
                          ),
                           SizedBox(height: 2.h,),
                          SizedBox(
                            width: double.infinity,
                            height: 8.h,
                            child: TextButton(
                              style: flatButtonStyle,
                              onPressed: () {
                                if(_verifyformKey.currentState!.validate()){
                                  verifyController.verify(context,verifyController.currentPin);
                                }
                              },
                              child: Text('login'.tr(),
                                style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_bold',
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),),
                            ),
                          ),
                           SizedBox(height: 3.h,),
                          Text('didnt_receive_code'.tr(), style:  TextStyle(fontSize: 12.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w500,
                              color: MyColors.Dark3)),
                          Center(
                            child: Obx(() =>
                                Visibility(
                                    visible: verifyController.isVisable
                                        .value,
                                    child: const CircularProgressIndicator(color: MyColors.MainColor,)
                                )),
                          ),
                          GestureDetector(
                            onTap: (){
                              verifyController.isVisable.value=true;
                              verifyController.resendCode(context);
                            },
                            child: Text('request_again'.tr(), style:  TextStyle(fontSize: 12.sp,
                                fontFamily: 'lexend_medium',
                                fontWeight: FontWeight.w500,
                                color: MyColors.MainColor)),
                          ),
                        ]
                  ),
                )
            )
        ),
      ),
    );
  }

  @override
  void dispose() {
    verfiyCodeController.dispose();
    super.dispose();
  }

}