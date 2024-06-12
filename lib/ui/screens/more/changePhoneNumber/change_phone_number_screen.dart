import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sizer/sizer.dart';

import '../../../../conustant/my_colors.dart';

class ChangePhoneNumberScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChangePhoneNumberScreen();
  }
}

class _ChangePhoneNumberScreen extends State<ChangePhoneNumberScreen>{
  TextEditingController PhoneController = TextEditingController();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final _formKey = GlobalKey<FormState>();
  var currentPin="";
  TextEditingController verfiyCodeController = TextEditingController();
  bool isClick=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BGColor,
      appBar: AppBar(
        backgroundColor: MyColors.BGColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/back.svg')
        ),
        title: Center(
          child: Text(
              'change_phone_number'.tr(), style:  TextStyle(fontSize: 14.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark1)),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        margin:  EdgeInsetsDirectional.only(end: 1.5.h,start: 1.5.h),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 4.h,),
                Text(
                    'change_phone_number'.tr(), style:  TextStyle(fontSize: 16.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w800,
                    color: MyColors.Dark1)),
                 SizedBox(height: 1.h,),
                Text(
                    'you_can_change'.tr(), style:  TextStyle(fontSize: 11.sp,
                    fontFamily: 'lexend_light',
                    fontWeight: FontWeight.w300,
                    color: MyColors.Dark3)),
                 SizedBox(height: 2.h,),
                Text(
                  'phone_number'.tr(),
                  style:  TextStyle(fontSize: 12.sp,
                      fontFamily: 'lexend_regular',
                      fontWeight: FontWeight.w400,
                      color: MyColors.Dark2),
                  textAlign: TextAlign.start,
                ),
                 SizedBox(height: 1.h,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                      color: Colors.white,),
                  child: PhoneNumber(),
                ),
                 SizedBox(height: 2.h,),
                !isClick?Container(
                  width: MediaQuery.of(context).size.width,
                  height: 8.h,
                  child: TextButton(
                    style: flatButtonStyle ,
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        setState(() {
                          isClick=true;
                        });

                      }
                    },
                    child: Text('send_OTP'.tr(),
                        style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                ):Container(),
                 SizedBox(height: 2.h,),
                isClick?
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset("assets/divider.svg"),
                       SizedBox(height: 2.h,),
                      Text(
                          'activation_code'.tr(), style:  TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_regular',
                          fontWeight: FontWeight.w400,
                          color: MyColors.Dark1)),
                      const SizedBox(height: 5,),
                      Text(
                          'enter_the_confirmation_code'.tr(), style:  TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_regular',
                          fontWeight: FontWeight.w400,
                          color: MyColors.Dark3)),
                       SizedBox(height: 1.h,),
                      Container(
                        margin: EdgeInsetsDirectional.only(end: 1.5.h,start: 1.5.h),
                        child: PinCodeTextField(
                          appContext: context,
                          length: 4, // Set the length of the PIN code
                          onChanged: (pin) {
                            setState(() {
                              currentPin = pin;
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
                          controller: verfiyCodeController,
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
                          textStyle:  TextStyle(fontSize: 11.sp),
                          onCompleted: (pin) {

                          },
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 8.h,
                        child: TextButton(
                          style: flatButtonStyle,
                          onPressed: () {
                            if(_formKey.currentState!.validate()){
                              Navigator.pushNamed(context, "/success_dialog_screen");
                            }
                          },
                          child: Text('verify'.tr(),
                            style:  TextStyle(fontSize: 12.sp,
                                fontFamily: 'lexend_bold',
                                fontWeight: FontWeight.w700,
                                color: Colors.white),),
                        ),
                      ),
                       SizedBox(height: 2.h,),
                      Center(
                        child: Text('didnt_receive_code'.tr(), style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color: MyColors.Dark3)),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: (){

                          },
                          child: Text('request_again'.tr(), style:  TextStyle(fontSize: 12.sp,
                              fontFamily: 'lexend_medium',
                              fontWeight: FontWeight.w500,
                              color: MyColors.MainColor)),
                        ),
                      ),
                    ],
                  ),
                ):Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget PhoneNumber (){
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      controller: PhoneController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_enter_phone_number'.tr();
        }else if(value.length<11){
          return 'phone_number_must'.tr();
        }
        return null;
      },
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon:   Padding(
            padding: EdgeInsetsDirectional.fromSTEB(1.2.h,0,1.2.h,0),
            child: Image(image: AssetImage('assets/ar.png',),width: 4.h,height: 4.h,)
        ),
        errorBorder:  const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: Colors.white70,style: BorderStyle.solid),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide(style: BorderStyle.solid,color: Colors.white70,)
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          borderSide: BorderSide(color: Colors.red,style: BorderStyle.solid),
        ) ,
        hintText: 'enter_phone'.tr(),
        hintStyle:  TextStyle(fontSize: 12.sp,
            fontFamily: 'lexend_regular',
            fontWeight: FontWeight.w300,
            color: MyColors.Dark3),
      ),
      style:  TextStyle(fontSize: 12.sp,
          fontFamily: 'lexend_regular',
          fontWeight: FontWeight.w300,
          color: MyColors.Dark3),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(11)],
    );
  }
}