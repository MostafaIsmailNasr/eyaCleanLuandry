import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/my_colors.dart';

import '../../../../business/auth/completeUserInfoController/CompleteUserInfoController.dart';
import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../location/location_screen.dart';
import 'dart:math' as math;

class CreateAccountScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CreateAccountScreen();
  }
}

class _CreateAccountScreen extends State<CreateAccountScreen>{
  final completeUserInfoController = Get.put(CompleteUserInfoController());
  final _formKey = GlobalKey<FormState>();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final changeLanguageController = Get.put(ChangeLanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: MyColors.BackGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //     onPressed: (){
        //       Navigator.pop(context);
        //     },
        //     icon: Transform.rotate(
        //     angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
        //     child: SvgPicture.asset('assets/back.svg',))
        // )
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:  EdgeInsetsDirectional.only(start: 2.5.h, end: 2.5.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('complete_your_profile'.tr(), style:  TextStyle(fontSize: 16.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w800,
                        color: MyColors.Dark1)),
                    const Spacer(),
                    GestureDetector(
                      onTap: (){
                        completeUserInfoController.lat="";
                        completeUserInfoController.lng="";
                        completeUserInfoController.address2.value="";
                        completeUserInfoController.type="";
                        completeUserInfoController.image=null;
                        Navigator.pushNamedAndRemoveUntil(context,'/drower',ModalRoute.withName('/drower'));
                      },
                      child: Container(
                        padding: EdgeInsetsDirectional.all(1.h),
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                            border: Border.all(color: Colors.white, width: 1.0,),
                            color: MyColors.MainColor),
                        child: Center(
                          child: Text('skip'.tr(),
                            style:  TextStyle(fontSize: 12.sp,
                                fontFamily: 'lexend_bold',
                                fontWeight: FontWeight.w700,
                                color: Colors.white),),
                        ),
                      ),
                    ),
                  ],
                ),
                Text('Please_enter_account'.tr(), style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2)),
                 SizedBox(height: 2.h,),
                Center(
                  child:SizedBox(
                    width: 50.w,
                    height: 18.h,
                    child:Column(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              uploadImage();
                            });
                          },
                          child: Container(
                            width: 25.w,
                            height: 12.h,
                            decoration:completeUserInfoController.image!=null?  BoxDecoration(
                                borderRadius: BorderRadius.circular(80),
                                color: MyColors.Dark2,
                                image: DecorationImage(image: FileImage(completeUserInfoController.image!),fit: BoxFit.fill),
                                border: Border.all(
                                    width: 1,
                                    color: MyColors.Dark3
                                )
                            ):
                            BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: const DecorationImage(image: AssetImage('assets/gallery.png',),fit: BoxFit.fill),
                            ),
                          ),
                        ) ,
                        SizedBox(height: 1.5.h,),
                        Text('add_profile_picture'.tr(),
                          style: TextStyle(fontSize: 11.sp,fontFamily: 'lexend_light',fontWeight: FontWeight.w300,color: MyColors.Dark2),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 3.h,),
                Text('full_name'.tr(), style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2)),
                 SizedBox(height: 1.h,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                      color: Colors.white),
                  child: Name(),
                ),
                SizedBox(height: 2.h,),
                Text('delivery_location'.tr(), style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2)),
                SizedBox(height: 1.h,),
                GestureDetector(
                  onTap: (){
                     Navigator.pushNamed(context, "/location_screen",arguments: "fromCreateAccount");
                  },
                  child: Container(
                    height: 10.h,
                    padding: EdgeInsetsDirectional.all(2.h),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                        color: Colors.white),
                    child: Location(),
                  ),
                ),
                SizedBox(height: 2.h,),
                Text('email_address'.tr(), style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2)),
                 SizedBox(height: 1.h,),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                      color: Colors.white),
                  child: Email(),
                ),
                 SizedBox(height: 2.h,),
                Center(
                  child: Obx(() =>
                      Visibility(
                          visible: completeUserInfoController.isVisable
                              .value,
                          child: const CircularProgressIndicator(color: MyColors.MainColor,)
                      )),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 8.h,
                  child: TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        completeUserInfoController.isVisable.value=true;
                        completeUserInfoController.completeUserInfo(context);
                      }
                    },
                    child: Text('create_my_account'.tr(),
                      style:  TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_bold',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                  ),
                ),
                 SizedBox(height: 1.h,),

                 SizedBox(height: 3.h,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadImage() async {
    final picker = ImagePicker();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('upload_image'.tr(),style:  TextStyle(fontSize: 16.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w800,
              color: MyColors.Dark1)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('camera'.tr(),style:  TextStyle(fontSize: 12.sp,
                      fontFamily: 'lexend_medium',
                      fontWeight: FontWeight.w500,
                      color: MyColors.Dark2)),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.getImage(source: ImageSource.camera);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        completeUserInfoController.image=File(pickedImage!.path);
                      });
                    }
                  },
                ),
                SizedBox(height: 1.h),
                GestureDetector(
                  child: Text('gallery'.tr(),
                      style:  TextStyle(
                          fontSize: 12.sp,
                          fontFamily: 'lexend_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark2)),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedImage = await picker.getImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      //File imageFile = File(pickedImage.path);
                      setState(() {
                        completeUserInfoController.image=File(pickedImage!.path);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget Name(){
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      controller: completeUserInfoController.nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_enter_name'.tr();
        }
        return null;
      },
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon:   Padding(
            padding: EdgeInsetsDirectional.fromSTEB(1.2.h,0,1.2.h,0),
            child: Image(image: AssetImage('assets/user.png',),width: 3.h,height: 3.h,)
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
        hintText: 'please_enter_name'.tr(),
        hintStyle:  TextStyle(fontSize: 12.sp,
            fontFamily: 'lexend_regular',
            fontWeight: FontWeight.w300,
            color: MyColors.Dark3),
      ),
      style:  TextStyle(fontSize: 12.sp,
          fontFamily: 'lexend_regular',
          fontWeight: FontWeight.w300,
          color: MyColors.Dark3),
    );
  }

  Widget Location(){
    return Row(
      children: [
        SvgPicture.asset('assets/location_add.svg',),
         SizedBox(width: 2.w,),
        SizedBox(
          width: 30.h,
          child:Obx(() =>completeUserInfoController.address2.value!=""? Text(
            completeUserInfoController.address2.value.toString(),style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_regular',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark3),maxLines: 2,)
              :Text('add_delivery_location'.tr(),
            style:TextStyle(fontSize: 12.sp,fontFamily: 'lexend_regular',fontWeight: FontWeight.w400,color: MyColors.Dark3),maxLines: 2,),
        )),
      ],
    );
  }

  Widget Email(){
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      controller: completeUserInfoController.emailController,
      maxLines: 1,
      validator: (value) {
        if (!value!.contains("@")&&!value!.contains(".")) {
          return 'please_enter_correct_email'.tr();
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon:   Padding(
            padding: EdgeInsetsDirectional.fromSTEB(1.2.h,0,1.2.h,0),
            child: Image(image: AssetImage('assets/sms.png',),width: 3.h,height: 3.h,)
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
        hintText: 'enter_your_email'.tr(),
        hintStyle:  TextStyle(fontSize: 12.sp,
            fontFamily: 'lexend_regular',
            fontWeight: FontWeight.w300,
            color: MyColors.Dark3),
      ),
      style:  TextStyle(fontSize: 12.sp,
          fontFamily: 'lexend_regular',
          fontWeight: FontWeight.w300,
          color: MyColors.Dark3),
    );
  }

}