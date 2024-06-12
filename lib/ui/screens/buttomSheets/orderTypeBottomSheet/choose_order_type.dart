import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/createOrderController/CreateOrderController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../conustant/toast_class.dart';
import '../../orders/newOrder/new_order_screen.dart';

class ChooseOrderType extends StatefulWidget{
  var id;
  ChooseOrderType(this.id);

  @override
  State<StatefulWidget> createState() {
    return _ChooseOrderType();
  }
}

class _ChooseOrderType extends State<ChooseOrderType>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  var isSelected=false;
  int? itemId=0;
  //var type;
  final createOrderController = Get.put(CreateOrderController());

  @override
  void initState() {
    createOrderController.offerId=widget.id;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Execute the code after the widget is built
      createOrderController.getOrderDays(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.h,left: 2.h,top: 1.h,bottom: 2.h),
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomBar(),
              Obx(() => !createOrderController.isLoading3.value? orderType():const Center(child: CircularProgressIndicator())),
              SizedBox(height: 2.h,),
              Container(
                // margin: EdgeInsets.only(left: 20, right: 20),
                width: double.infinity,
                height: 8.h,
                child: TextButton(
                  style: flatButtonStyle,
                  onPressed: () {
                    if(isSelected!=false){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewOrderScreen(
                          createOrderController.type,
                          createOrderController.daySettingResponse.value.data?.normalAfterDays?.value??"",
                          createOrderController.daySettingResponse.value.data?.urgentAfterDays?.value??"")));
                      //Navigator.pushNamed(context, "/new_order_screen",arguments: type);
                    }else{
                      ToastClass.showCustomToast(context, 'please_choose_order_type'.tr(), 'error');
                    }
                  },
                  child: Text('keep_going'.tr(),
                    style:  TextStyle(fontSize: 12.sp,
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
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('new_order'.tr(),
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
              Text('please_select_the_order_type'.tr(),
                style:  TextStyle(fontSize: 10.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark3),
              ),
            ],
          ),
        ),
        SizedBox(height: 1.h,),
      ],
    );
  }

  Widget orderType(){
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            setState(() {
              isSelected=true;
              createOrderController.type="normal";
              itemId=1;
            });
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 11.h,
            padding:  EdgeInsetsDirectional.all(1.h),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color:isSelected==true && itemId==1?MyColors.MainColor2: MyColors.Dark5, width: 2.0,),
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.asset('assets/normal_orders.png',width: 7.h,)),
                   SizedBox(width: 1.h,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('normal'.tr(),
                        style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_medium',
                            fontWeight: FontWeight.w500,
                            color: MyColors.Dark1),
                      ),
                      Row(
                        children: [
                          Text('receive_your_order_within_hours'.tr(),
                            style:  TextStyle(fontSize: 8.sp,
                                fontFamily: 'lexend_regular',
                                fontWeight: FontWeight.w400,
                                color: MyColors.Dark3),
                          ),
                          Text("${createOrderController.daySettingResponse.value.data?.normalAfterDays?.value??""} ${'day'.tr()}",
                            style:  TextStyle(fontSize: 8.sp,
                                fontFamily: 'lexend_regular',
                                fontWeight: FontWeight.w400,
                                color: MyColors.Dark3),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Center(
                    child: isSelected==true && itemId==1?
                    SvgPicture.asset('assets/checked.svg'):SvgPicture.asset('assets/unChecked.svg')
                  )
                ],
            ),
          ),
        ),
         SizedBox(height: 1.h,),
        GestureDetector(
          onTap: (){
            setState(() {
              isSelected=true;
              createOrderController.type="urgent";
              itemId=2;
            });

          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 11.h,
            padding:  EdgeInsetsDirectional.all(1.h),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color:isSelected==true && itemId==2?MyColors.MainColor2: MyColors.Dark5, width: 2.0,),
                color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: SvgPicture.asset('assets/urgent_orders.svg',)),
                 SizedBox(width: 1.h,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('urgent'.tr(),
                      style:  TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                    ),
                    Row(
                      children: [
                        Text('receive_your_order_within_hours2'.tr(),
                          style:  TextStyle(fontSize: 8.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark3),
                        ),
                        Text("${createOrderController.daySettingResponse.value.data?.urgentAfterDays?.value??""} ${'day'.tr()}",
                          style:  TextStyle(fontSize: 8.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark3),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Center(
                    child: isSelected==true && itemId==2?
                    SvgPicture.asset('assets/checked.svg'):SvgPicture.asset('assets/unChecked.svg')
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}