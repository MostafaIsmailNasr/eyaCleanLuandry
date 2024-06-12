import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../conustant/di.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../conustant/shared_preference_serv.dart';
import '../../../../conustant/toast_class.dart';

class ChooseLanguageDialog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ChooseLanguageDialog();
  }
}

class _ChooseLanguageDialog extends State<ChooseLanguageDialog>{
  var isSelected=false;
  int? itemId=0;
  final changeLanguageController = Get.put(ChangeLanguageController());
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();

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
                    changeLanguageController.lang='ar';
                    sharedPreferencesService.setString("lang", changeLanguageController.lang);
                    translator.setNewLanguage(
                      context,
                      newLanguage: changeLanguageController.lang,
                      remember: true,
                    );
                    Phoenix.rebirth(context);
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 6.h,
                  margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                  padding:  EdgeInsets.all(1.h),
                  child: Row(
                    children: [
                      Image.asset('assets/egypt.png',width: 3.h,),
                       SizedBox(width: 1.h,),
                      Text('arabic'.tr(),
                        style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color: MyColors.Dark1),),
                      const Spacer(),
                      isSelected==true && itemId==1?SvgPicture.asset('assets/rado_checked.svg',color: MyColors.SecondryColor,):SvgPicture.asset('assets/rado_unChecked.svg',),
                    ],
                  ),
                ),
              ),
              Container(
                  margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                  child: SvgPicture.asset('assets/separator.svg')),
              const SizedBox(height: 10,),
              InkWell(
                onTap: (){
                  setState(() {
                    isSelected=true;
                    itemId=2;
                    changeLanguageController.lang='en';
                    sharedPreferencesService.setString("lang", changeLanguageController.lang);
                    translator.setNewLanguage(
                      context,
                      newLanguage: changeLanguageController.lang,
                      remember: true,
                    );
                    Phoenix.rebirth(context);
                    Navigator.pop(context);
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 6.h,
                  margin:  EdgeInsetsDirectional.only(start: 1.h,end: 1.h),
                  padding:  EdgeInsets.all(1.h),
                  child: Row(
                    children: [
                      Image.asset('assets/english.png',width: 3.h,),
                       SizedBox(width: 1.h,),
                      Text('english'.tr(),
                        style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color: MyColors.Dark1),),
                      const Spacer(),
                      isSelected==true && itemId==2?SvgPicture.asset('assets/rado_checked.svg',color: MyColors.SecondryColor):SvgPicture.asset('assets/rado_unChecked.svg',),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
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
              Text('choose_language'.tr(),
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
}