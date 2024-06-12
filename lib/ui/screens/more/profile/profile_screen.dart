import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../business/profileController/ProfileController.dart';
import '../../../../conustant/my_colors.dart';
import 'dart:math' as math;

class ProfileScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreen();
  }
}

class _ProfileScreen extends State<ProfileScreen>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final profileController=Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  final changeLanguageController = Get.put(ChangeLanguageController());

  @override
  void initState() {
    getUserDataFromLocal();
    super.initState();
  }

  getUserDataFromLocal()async{
    setState(() {
      profileController.name=profileController.sharedPreferencesService.getString("fullName")??"";
      profileController.pic=profileController.sharedPreferencesService.getString("picture")??"";
      profileController.phone=profileController.sharedPreferencesService.getString("phone_number")??"";
      print("phooo"+profileController.phone);
      profileController.email=profileController.sharedPreferencesService.getString("email")??"";
      profileController.nameController.text=profileController.name;
      profileController.PhoneController.text=profileController.phone;
      profileController.emailController.text=profileController.email;
    });

  }
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
            icon: Transform.rotate(
                angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
                child: SvgPicture.asset('assets/back.svg'))
        ),
        title: Center(
          child: Text(
              'my_account'.tr(), style:  TextStyle(fontSize: 14.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w400,
              color: MyColors.Dark1)),
        ),
      ),
      body:Obx(() =>!profileController.isLoading.value?
      SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin:  EdgeInsets.only(left: 2.h,right: 2.h,top: 3.h),
          child: Form(
            key:_formKey ,
            child: Column(
              children: [
                Center(
                  child:Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            uploadImage();
                          });
                        },
                        child: Container(
                          width: 12.h,
                          height: 12.h,
                          decoration:profileController.image!=null?  BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: MyColors.Dark5,
                              image: DecorationImage(image: FileImage(profileController.image!),fit: BoxFit.fill),
                              border: Border.all(
                                  width: 1,
                                  color: MyColors.Dark3
                              )
                          ):
                          BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image:
                              DecorationImage(image: NetworkImage(profileController.pic,),fit: BoxFit.fill)//:
                          ),
                        ),
                      ) ,
                      SizedBox(height: 1.h,),
                      Text('change_profile_picture'.tr(),
                        style:  TextStyle(fontSize: 11.sp,
                            fontFamily: 'lexend_light',
                            fontWeight: FontWeight.w300,
                            color: MyColors.Dark2),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'full_name'.tr(),
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
                          color: Colors.white),
                      child: Name(),
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'phone_number'.tr(),
                          style:  TextStyle(fontSize: 12.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark2),
                          textAlign: TextAlign.start,
                        ),
                        /*GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "/change_phone_number_screen");
                          },
                          child: Text(
                            'update'.tr(),
                            style:  TextStyle(fontSize: 12.sp,
                                fontFamily: 'lexend_regular',
                                fontWeight: FontWeight.w400,
                                color: MyColors.MainColor),
                            textAlign: TextAlign.start,
                          ),
                        ),*/
                      ],
                    ),
                    SizedBox(height: 1.h,),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                          border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                          color: Colors.white),
                      child: PhoneNumber(),
                    ),
                  ],
                ),
                SizedBox(height: 2.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'email_address2'.tr(),
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
                          color: Colors.white),
                      child: Email(),
                    ),
                  ],
                ),
                SizedBox(height: 1.h,),
                Center(
                  child: Obx(() =>
                      Visibility(
                          visible: profileController.isVisabl
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
                      if(_formKey.currentState!.validate()) {
                        profileController.isVisabl.value = true;
                        profileController.profile(context);
                      }
                    },
                    child: Text('update'.tr(),
                        style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                ),
                SizedBox(height: 1.h,),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(context,'/Login_screen',ModalRoute.withName('/Login_screen'));
                  },
                  child: Text('delete_my_account'.tr(),
                      style:  TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.STATUSEREDColor)),
                )
              ],
            ),
          ),
        ),
      )
          : const Center(child: CircularProgressIndicator(color: MyColors.MainColor,),))
    );
  }

  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/no_internet.png'),
          SizedBox(height: 10,),
          Text('there_are_no_internet'.tr(),
            style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
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
                        profileController.image=File(pickedImage!.path);
                      });
                    }
                  },
                ),
                SizedBox(height: 10),
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
                        profileController.image=File(pickedImage!.path);
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
      controller: profileController.nameController,
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

  Widget Email(){
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      controller: profileController.emailController,
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon:   Padding(
            padding: EdgeInsetsDirectional.fromSTEB(1.2.h,0,1.2.h,0),
            child: Image(image: AssetImage('assets/sms.png',),width: 3.h,height: 3.h,)
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

  Widget PhoneNumber (){
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      controller: profileController.PhoneController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'please_enter_phone_number'.tr();
        }else if(value.length<10){
          return 'phone_number_must'.tr();
        }
        return null;
      },
      maxLines: 1,
      decoration: InputDecoration(
        prefixIcon:   Padding(
            padding: EdgeInsetsDirectional.fromSTEB(1.2.h,0,1.2.h,0),
            child: Image(image: AssetImage('assets/ar.png',),width: 3.h,height: 3.h,)
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
        LengthLimitingTextInputFormatter(10)],
    );
  }

}