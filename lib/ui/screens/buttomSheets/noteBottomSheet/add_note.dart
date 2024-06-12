import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/createOrderController/CreateOrderController.dart';
import '../../../../conustant/my_colors.dart';

class AddNote extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _AddNote();
  }
}

class _AddNote extends State<AddNote>{
  final formkey=GlobalKey<FormState>();
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
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBar(),
              content(context),
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
              Text('add_notes'.tr(),
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
        SizedBox(height: 10,),
      ],
    );
  }

  Widget content(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 1.h),
      child: Form(
        key: formkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 15.h,
              padding:  EdgeInsets.only(left: 1.h, right: 1.h),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: MyColors.Dark5)),
              child: note(),
            ),
             SizedBox(height: 1.h,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 8.h,
              child: TextButton(
                style: flatButtonStyle ,
                onPressed: (){
                  if(formkey.currentState!.validate()){
                    Navigator.pop(context);
                  }
                },
                child: Text('confirm'.tr(),
                  style: TextStyle(fontSize: 12.sp,
                      fontFamily: 'lexend_bold',
                      fontWeight: FontWeight.w700,
                      color: Colors.white),),
              ),
            ),
             SizedBox(height: 2.h,),
          ],
        ),
      ),
    );
  }

  Widget note (){
    return TextFormField(
      autovalidateMode:AutovalidateMode.onUserInteraction ,
      controller: createOrderController.NotesAddressController,
      validator: (String? validate){
        if(createOrderController.NotesAddressController.text.isEmpty){
          return 'add_notes_here'.tr();
        }
        return null;
      },
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