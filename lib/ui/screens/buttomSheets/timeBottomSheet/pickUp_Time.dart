import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/toast_class.dart';

import '../../../../business/createOrderController/CreateOrderController.dart';
import '../../../../business/pickUpController/PickUpController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget/DateItem.dart';
import '../../../widget/TimeItem.dart';
import 'package:intl/intl.dart';

import '../dropDownTimeButtomSheet/drop_down_time_buttomSheet.dart';

class PickUpTime extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _PickUpTime();
  }
}

class _PickUpTime extends State<PickUpTime>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  var selectedFlage=0;
  var selectedFlageTime;
  final pickUpController = Get.put(PickUpController());
  final createOrderController = Get.put(CreateOrderController());

  @override
  void initState() {
    pickUpController.getPickUpDates(context);
    pickUpController.PickDate=null;
    pickUpController.PickDateHours=null;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() =>!pickUpController.isLoading.value?Padding(
      padding:  EdgeInsets.only(right: 2.h,left: 2.h,top: 1.h,bottom: 1.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomBar(),
             SizedBox(height: 1.h,),
              dateList(),
             SizedBox(height: 1.h,),
            Obx(() =>!pickUpController.isLoading2.value? timeList()
            :const Center(child: CircularProgressIndicator(color: MyColors.MainColor),)),
             SizedBox(height: 1.h,),
            SizedBox(
              width: double.infinity,
              height: 8.h,
              child: TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  if(pickUpController.PickDate!=null&&pickUpController.PickDateHours!=null){
                    pickUpController.finalPickupTime.value=pickUpController.PickDate+" "+pickUpController.PickDateHours;
                    Navigator.pop(context);
                    if(createOrderController.addressId==null){
                      ToastClass.showCustomToast(context, 'please_choose_your_address_first'.tr(), "error");
                    }
                    else if(pickUpController.finalPickupTime.value==""){
                      ToastClass.showCustomToast(context, 'please_choose_pickUp_date'.tr(), "error");
                    } else{
                      showModalBottomSheet<void>(
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (BuildContext context) =>
                              Padding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery
                                          .of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      dropDownTimeButtomSheet(
                                          type: createOrderController.typeOfOrder,date: pickUpController.PickDate),
                                    ],
                                  )));
                    }
                  }else{
                    ToastClass.showCustomToast(context, 'please_select_date_and_time_first'.tr(), "error");
                  }
                },
                child: Text('save'.tr(),
                  style:  TextStyle(fontSize: 12.sp,
                      fontFamily: 'lexend_bold',
                      fontWeight: FontWeight.w700,
                      color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    ):const Center(child: CircularProgressIndicator(color: MyColors.MainColor,),));
  }

  Widget CustomBar(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 3.h,),
        SizedBox(
          height: 4.h,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Text('pick_up_date'.tr(),
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w700,
                    color: MyColors.Dark1),
              ),
              const Spacer(),
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

  Widget dateList() {
    return Container(
      height: 12.h,
      margin: EdgeInsetsDirectional.only(bottom: 1.5.h),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: pickUpController.pickUpDateList.length,
          itemBuilder: (context,int index){
            return DateItem(
              is_selected: selectedFlage==index,
              onTap: () {
                setState(() {
                  selectedFlage=index;
                  selectedFlageTime=null;
                   pickUpController.PickDate=pickUpController.pickupDateResponse.value.data![index].date;
                  pickUpController.getPickUpHoursDates(context);
                });
              },
              pickUpDate: pickUpController.pickUpDateList[index]
            );
          }
      ),
    );
  }

  Widget timeList() {
    if(pickUpController.hoursResponse.value.data!.isNotEmpty){
      return SizedBox(
          height: 20.h,
          child:
          GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: (2 / 1),
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: pickUpController.pickUpHoursList.length,
              itemBuilder: (context, int index) {
                return TimeItem(
                    is_selected: selectedFlageTime==index,
                    onTap:pickUpController.hoursResponse.value.data?[index].isAvailable==true? () {
                      setState(() {
                        selectedFlageTime=index;
                        String inputTime=pickUpController.hoursResponse.value.data![index].time!;
                        final inputFormat = DateFormat('h:mm a');
                        final outputFormat = DateFormat('HH:mm');
                        DateTime dateTime = inputFormat.parse(inputTime);
                        pickUpController.PickDateHours = outputFormat.format(dateTime);

                      });
                    }:null,
                    hours: pickUpController.pickUpHoursList[index]
                );
              }));
    }else{
      return Container(
          height: 20.h,
          child:empty());
    }
  }

}

class empty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
     // margin: EdgeInsets.only(top: 60),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset('assets/no_times.svg',width: 90,height: 90,),
              //SizedBox(height: 10,),
              Text('there_are_no_times'.tr(),
                style: TextStyle(fontSize: 14.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark1),
                textAlign: TextAlign.center,
              ),
              //SizedBox(height: 10,),
              Text('your_times_will_appear_here'.tr(),
                style: TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}