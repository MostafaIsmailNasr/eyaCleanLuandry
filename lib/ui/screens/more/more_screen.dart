import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/my_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../business/moreController/MoreController.dart';
import '../../../conustant/di.dart';
import '../../../conustant/shared_preference_serv.dart';
import '../../../data/model/updateTokenModel/UpdateTokenResponse.dart';
import '../../../data/reposatory/repo.dart';
import '../../../data/web_service/WebServices.dart';
import '../buttomSheets/chooseLanguageButtomSheet/choose_Language_dialog.dart';

class MoreScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MoreScreen();
  }
}

class _MoreScreen extends State<MoreScreen>{
  final moreController = Get.put(MoreController());

  @override
  void initState() {
    moreController.getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BGColor,
      appBar: AppBar(
        backgroundColor: MyColors.BGColor,
        automaticallyImplyLeading: false,
      ),
      body: OfflineBuilder(
        connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child,){
           bool connected = true;//connectivity == ConnectivityResult.none;
            if (connected) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 3.h,),
                    Center(
                      child: Column(
                        children: [
                          SizedBox(
                          width: 25.w,
                          height: 12.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.network(
                              moreController.pic,
                              loadingBuilder: (context, child,
                                      loadingProgress) =>
                                  (loadingProgress == null)
                                      ? child
                                      : Center(
                                          child: CircularProgressIndicator()),
                            ),
                          ),
                        ),
                        Text(
                              moreController.name??"", style:  TextStyle(fontSize: 14.sp,
                              fontFamily: 'lexend_medium',
                              fontWeight: FontWeight.w500,
                              color: MyColors.Dark1)),
                          Text(
                              moreController.phone??"", style:  TextStyle(fontSize: 10.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark3)),
                        ],
                      ),
                    ),
                    SizedBox(height: 2.h,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "/profile_screen");
                      },
                      child: Container(
                        color: Colors.white,
                        padding:  EdgeInsetsDirectional.all(2.h),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/my_account.svg',width: 6.w,height: 6.h,),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('my_account'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark1)),
                                Text('change_your_phone_number_and_account_details'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    /*Container(
              color: Colors.white,
              padding:  EdgeInsetsDirectional.all(2.h),
              child: Row(
                children: [
                  SvgPicture.asset('assets/pay.svg',width: 6.w,height: 6.h),
                   SizedBox(width: 1.h,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('payment_method'.tr(), style:  TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_regular',
                          fontWeight: FontWeight.w400,
                          color:MyColors.Dark1)),
                      Text('Add_your_credit_cards'.tr(), style:  TextStyle(fontSize: 8.sp,
                          fontFamily: 'lexend_regular',
                          fontWeight: FontWeight.w400,
                          color:MyColors.Dark3)),
                    ],
                  )
                ],
              ),
            ),
             SizedBox(height: 0.5.h,),*/
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/wallet_screen');
                      },
                      child: Container(
                        color: Colors.white,
                        padding:  EdgeInsetsDirectional.all(2.h),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/wallet.svg',width: 6.w,height: 6.h),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('my_wallet'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark1)),
                                Text('track_your_wallet_balance_and_transactions'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/my_address_screen');
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsetsDirectional.all(15),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/location.svg',width: 6.w,height: 6.h),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('my_locations'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark1)),
                                Text('control_your_delivery_addresses'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/share_code_screen');
                      },
                      child: Container(
                        color: Colors.white,
                        padding:  EdgeInsetsDirectional.all(2.h),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/share_code.svg',width: 6.w,height: 6.h),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('share_code'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark1)),
                                Text('Share_code_and_get_gifts_from_the_app'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/about_app_screen');
                      },
                      child: Container(
                        color: Colors.white,
                        padding:  EdgeInsetsDirectional.all(2.h),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/about.svg',width: 6.w,height: 6.h),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('about_app'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark1)),
                                Text('Overview_and_information_about_the_app'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/faqs');
                      },
                      child: Container(
                        color: Colors.white,
                        padding:  EdgeInsetsDirectional.all(2.h),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/faq.svg',width: 6.w,height: 6.h),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('fAQS'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark1)),
                                Text('The_most_common_questions_of_users'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/terms_and_condition_screen');
                      },
                      child: Container(
                        color: Colors.white,
                        padding:  EdgeInsetsDirectional.all(2.h),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/term.svg',width: 6.w,height: 6.h),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Terms_and_Conditions'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark1)),
                                Text('App_terms_and_conditions'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    GestureDetector(
                      onTap: (){
                        whatsappClient();
                      },
                      child: Container(
                        color: Colors.white,
                        padding:  EdgeInsetsDirectional.all(2.h),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/contact_us.svg',width: 6.w,height: 6.h),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('live_support'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark1)),
                                Text('Contact_us_all_day'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    GestureDetector(
                      onTap: (){
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            context: context,
                            backgroundColor: Colors.white,
                            builder: (BuildContext context) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: ChooseLanguageDialog()));
                      },
                      child: Container(
                        color: Colors.white,
                        padding:  EdgeInsetsDirectional.all(2.h),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/lang.svg',width: 6.w,height: 6.h),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('language'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark1)),
                                Text('Choose_your_preferred_language'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0.5.h,),
                    GestureDetector(
                      onTap: ()async{
                        moreController.updateToken(context);
                      },
                      child: Container(
                        color: Colors.white,
                        padding:  EdgeInsetsDirectional.all(2.h),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/logout.svg',width: 6.w,height: 6.h),
                            SizedBox(width: 1.h,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('logout'.tr(), style:  TextStyle(fontSize: 12.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.STATUSEREDColor)),
                                Text('log_out_of_your_account'.tr(), style:  TextStyle(fontSize: 8.sp,
                                    fontFamily: 'lexend_regular',
                                    fontWeight: FontWeight.w400,
                                    color:MyColors.Dark3)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h,),
                  ],
                ),
              );
            }else{
              return  Scaffold(body: NoIntrnet());
            }
    },
        child: const Center(
          child: CircularProgressIndicator(
            color: MyColors.MainColor,
          ),
        ),
      )
      ,
    );
  }

  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //SvgPicture.asset('assets/no_internet.svg'),
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

  whatsappClient()async{
    var phone2=moreController.socialResponse.value.data!.contactUs!.value![1].link.toString();
    var iosUrl = "https://wa.me/$phone2";
    var  url='https://api.whatsapp.com/send?phone=$phone2';
    if(Platform.isIOS){
      await launchUrl(Uri.parse(iosUrl));
    }
    else{
      await launch(url);
    }
  }
}