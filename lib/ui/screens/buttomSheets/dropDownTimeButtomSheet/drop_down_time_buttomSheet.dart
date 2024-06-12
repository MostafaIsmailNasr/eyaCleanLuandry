
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/dropOffController/DropOffController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../conustant/toast_class.dart';
import '../../../widget/DateDropItem.dart';
import '../../../widget/DateItem.dart';
import '../../../widget/TimeDropItem.dart';
import '../../../widget/TimeItem.dart';

class dropDownTimeButtomSheet extends StatefulWidget{
  var type;
  var date;

  dropDownTimeButtomSheet({required this.type,required this.date});

  @override
  State<StatefulWidget> createState() {
    return _dropDownTimeButtomSheet();
  }
}

class _dropDownTimeButtomSheet extends State<dropDownTimeButtomSheet>{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  var selectedFlage=0;
  var selectedFlageTime;
  final dropOffController = Get.put(DropOffController());

  @override
  void initState() {
    dropOffController.getDropOffDates(widget.type,widget.date,context);
    dropOffController.dropDate=null;
    dropOffController.dropDateHours=null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>!dropOffController.isLoading.value? Padding(
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
        Obx(() =>!dropOffController.isLoading2.value?timeList()
            :const Center(child: CircularProgressIndicator(color: MyColors.MainColor),)),
            SizedBox(height: 1.h,),
            SizedBox(
              width: double.infinity,
              height: 8.h,
              child: TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  if(dropOffController.dropDate!=null&&dropOffController.dropDateHours!=null){
                    dropOffController.finalDropOffTime.value=dropOffController.dropDate+" "+dropOffController.dropDateHours;
                    Navigator.pop(context);
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
    )
    :const Center(child: CircularProgressIndicator(color: MyColors.MainColor),));
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
              Text('drop_off_date'.tr(),
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
          itemCount: dropOffController.dropOffDateList.length,
          itemBuilder: (context,int index){
            return DateDropItem(
              is_selected: selectedFlage==index,
              onTap: () {
                setState(() {
                  selectedFlage=index;
                  selectedFlageTime=null;
                  dropOffController.dropDate=dropOffController.dropOffDateResponse.value.data![index].date;
                  dropOffController.getPickUpHoursDates(context);
                });
              },
                dropOffDates: dropOffController.dropOffDateList[index]
            );
          }
      ),
    );
  }

  Widget timeList() {
    if(dropOffController.hoursResponse.value.data!.isNotEmpty){
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
              itemCount: dropOffController.dropOffHoursList.length,
              itemBuilder: (context, int index) {
                return TimeDropItem(
                    is_selected: selectedFlageTime==index,
                    onTap:dropOffController.hoursResponse.value.data?[index].isAvailable==true? () {
                      setState(() {
                        selectedFlageTime=index;
                        String inputTime=dropOffController.hoursResponse.value.data![index].time!;
                        final inputFormat = DateFormat('h:mm a');
                        final outputFormat = DateFormat('HH:mm');
                        DateTime dateTime = inputFormat.parse(inputTime);
                        dropOffController.dropDateHours = outputFormat.format(dateTime);
                      });
                    }:null,
                    hours: dropOffController.dropOffHoursList[index]
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