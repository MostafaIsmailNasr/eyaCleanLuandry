import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../business/createOrderController/CreateOrderController.dart';
import '../../../../business/dropOffController/DropOffController.dart';
import '../../../../business/pickUpController/PickUpController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../conustant/toast_class.dart';
import '../../../widget/CartItem.dart';
import '../../buttomSheets/addressBottomSheet/choose_address.dart';
import 'dart:math' as math;

import '../../buttomSheets/dropDownTimeButtomSheet/drop_down_time_buttomSheet.dart';
import '../../buttomSheets/noteBottomSheet/add_note.dart';
import '../../buttomSheets/promotionalCodeButtomSheet/Add_promotional_code.dart';

class CreateQuickOrderScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CreateQuickOrderScreen();
  }
}

class _CreateQuickOrderScreen extends State<CreateQuickOrderScreen>{
  var isSelected=false;
  int? itemId=0;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final createOrderController = Get.put(CreateOrderController());
  final pickUpController = Get.put(PickUpController());
  final dropOffController = Get.put(DropOffController());
  final changeLanguageController = Get.put(ChangeLanguageController());

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      setState(() {
        pickUpController.finalPickupTime.value="";
        dropOffController.finalDropOffTime.value="";
        createOrderController.getAddressList(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.BGColor,
        appBar: AppBar(
          backgroundColor: MyColors.BGColor,
          leading: IconButton(
              onPressed: () {
                createOrderController.offerId="";
                createOrderController.lng="";
                createOrderController.lat="";
                createOrderController.streetName.value="";
                createOrderController.payment.value="";
                createOrderController.typeOfOrder="";
                createOrderController.CopunID="";
                createOrderController.addressId=null;
                createOrderController.codeController.clear();
                createOrderController.promocode.value="";
                pickUpController.PickDate="";
                pickUpController.PickDateHours="";
                dropOffController.dropDate="";
                dropOffController.dropDateHours="";
                createOrderController.totalPrice.value=0;
                createOrderController.itemPrices=[];
                createOrderController.quantityList.value=0;
                Navigator.pop(context);
              },
              icon: Transform.rotate(
                  angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
                  child: SvgPicture.asset('assets/back.svg',))
          ),
          title: Center(
            child: Text(
                'quick_order'.tr(), style:  TextStyle(fontSize: 14.sp,
                fontFamily: 'lexend_bold',
                fontWeight: FontWeight.w400,
                color: MyColors.Dark1)),
          ),
        ),
        body:Obx(() => !createOrderController.isLoading.value? SingleChildScrollView(
          child: Container(
            margin: EdgeInsetsDirectional.only(start: 1.5.h,end: 1.5.h),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                orderType(),
                SizedBox(height: 3.h,),
                driver(),
                SizedBox(height: 3.h,),
                categoryCart(),
                SizedBox(height: 1.h,),
                Text('pick_up_location'.tr(), style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2)),
                pickUpLocation(),
                SizedBox(height: 1.h,),
                Text('drop_off_date2'.tr(), style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2)),
                dropOfDate(),
                SizedBox(height: 3.h,),
                bottomContent()
              ],
            ),
          ),
        ):const Center(child: CircularProgressIndicator()))
    );
  }

  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/no_internet.png'),
          SizedBox(height: 1.h,),
          Text('there_are_no_internet'.tr(),
            style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

  Widget orderType(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                isSelected=true;
                itemId=1;
                dropOffController.dropDate="";
                dropOffController.dropDateHours="";
                dropOffController.finalDropOffTime.value="";
                createOrderController.typeOfOrder="normal";
              });
            },
            child: Container(
              height: 20.h,
              padding:  EdgeInsetsDirectional.all(1.h),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color:isSelected==true && itemId==1?MyColors.MainColor: MyColors.Dark5, width: 2.0,),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Image.asset('assets/normal_orders.png',width: 7.h,)),
                  SizedBox(width: 1.h,),
                  Text('normal'.tr(),
                    style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_medium',
                        fontWeight: FontWeight.w500,
                        color: MyColors.Dark1),
                  ),
                  SizedBox(height: 1.h,),
                  // Text("${'receive_your_order_within_hours'.tr()+widget.orderTextNormal} ${'day'.tr()}",
                  //     style:  TextStyle(fontSize: 8.sp,
                  //         fontFamily: 'lexend_regular',
                  //         fontWeight: FontWeight.w400,
                  //         color: MyColors.Dark3),textAlign: TextAlign.center
                  // ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 1.h,),
        Expanded(
          child: GestureDetector(
            onTap: (){
              setState(() {
                isSelected=true;
                itemId=2;
                dropOffController.dropDate="";
                dropOffController.dropDateHours="";
                dropOffController.finalDropOffTime.value="";
                createOrderController.typeOfOrder="urgent";
              });

            },
            child: Container(
              // width: 160,
              height: 20.h,
              padding:  EdgeInsetsDirectional.all(1.h),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color:isSelected==true && itemId==2?MyColors.MainColor: MyColors.Dark5, width: 2.0,),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: SvgPicture.asset('assets/urgent_orders.svg',)),
                  SizedBox(width: 1.h,),
                  Text('urgent'.tr(),
                    style:  TextStyle(fontSize: 12.sp,
                        fontFamily: 'lexend_medium',
                        fontWeight: FontWeight.w500,
                        color: MyColors.Dark1),
                  ),
                  SizedBox(height: 1.h,),
                  // Text("${'receive_your_order_within_hours2'.tr()+widget.orderTextUrgent} ${'day'.tr()}",
                  //   style:  TextStyle(fontSize: 8.sp,
                  //       fontFamily: 'lexend_regular',
                  //       fontWeight: FontWeight.w400,
                  //       color: MyColors.Dark3),textAlign: TextAlign.center,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget driver(){
    return  Container(
     // margin: EdgeInsetsDirectional.only(start: 1.5.h,end: 1.5.h,top: 1.5.h,bottom: 1.h),
      padding: EdgeInsetsDirectional.all(1.5.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          border: Border.all(color:MyColors.MainColor,width: 1)
      ),
      child: Row(
        children: [
          Image.asset('assets/driver.png',width: 6.h,),
          SizedBox(width: 1.h,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 30.h,
                child: Row(
                  children: [
                    Text("Zaid Hassan",maxLines: 2,
                      style: TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                    ),
                    const Spacer(),
                    Text("4 KM",maxLines: 1,
                      style: TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_medium',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),
                    ),
                  ],
                ),
              ),
              Text("4 ${'min_away'.tr()}",
                style: TextStyle(fontSize: 10.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark1),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget categoryCart(){
    return ExpandableNotifier(
      child: Container(
        //margin: EdgeInsetsDirectional.all(1.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: MyColors.Dark5,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(0.5.h),
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    hasIcon: true,
                    iconPlacement: ExpandablePanelIconPlacement.right,
                    iconColor: Colors.black,
                    collapseIcon: Icons.keyboard_arrow_up_outlined,
                    expandIcon: Icons.keyboard_arrow_down_outlined,
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                    padding: EdgeInsets.all(2.h),
                    child: Row(
                      children: [
                        Text(
                          'category'.tr(),
                          style: TextStyle(
                              fontSize: 12.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark3),
                        ),
                        const Spacer(),
                        Text(
                          "${'piece'.tr()} ",
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark1),
                        ),
                        Text(
                          createOrderController.quantityList.value.toString(),
                          style: TextStyle(
                              fontSize: 8.sp,
                              fontFamily: 'lexend_regular',
                              fontWeight: FontWeight.w400,
                              color: MyColors.Dark3),
                        ),
                      ],
                    ),
                  ),
                  collapsed: const SizedBox.shrink(),
                  expanded: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var _ in Iterable.generate(1))
                        Padding(
                            padding: EdgeInsets.only(bottom: 1.h),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 0.2.h,
                                  color: MyColors.BackGroundColor,
                                ),
                               // piecesList(),
                              ],
                            )
                          //Text(answer!,),
                        ),
                    ],
                  ),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: 1.h,
                        right: 1.h,
                        bottom: 1.h,
                      ),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget piecesList(){
  //   return Container(
  //     margin: EdgeInsetsDirectional.all( 2.h),
  //     child: ListView.builder(
  //         physics: const NeverScrollableScrollPhysics(),
  //         scrollDirection: Axis.vertical,
  //         shrinkWrap: true,
  //         itemCount: 5,
  //         itemBuilder: (context,int index){
  //           return CartItem();
  //         }
  //     ),
  //   );
  // }

  Widget pickUpLocation(){
    return GestureDetector(
      onTap: (){
        dropOffController.dropDate="";
        dropOffController.dropDateHours="";
        dropOffController.finalDropOffTime.value="";
        pickUpController.PickDate="";
        pickUpController.PickDateHours="";
        pickUpController.finalPickupTime.value="";

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
                child: ChooseAddress(from: "newOrder",)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 8.5.h,
        padding:  EdgeInsetsDirectional.all(1.h),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: MyColors.Dark5, width: 1.0,),
            color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() =>createOrderController.streetName.value!=""
                ? Container(
              width: 32.h,
              child: Text(
                createOrderController.streetName.value.toString(),
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark3),
                maxLines: 2,
              ),
            )
                :Text('add_location'.tr(),
              style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_regular',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark3),
            )),
            Spacer(),
            Transform.rotate(
                angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
                child: SvgPicture.asset('assets/arrow_right.svg',)),
          ],
        ),
      ),
    );
  }

  Widget dropOfDate(){
    return GestureDetector(
      onTap: (){
        if(createOrderController.addressId==null){
          ToastClass.showCustomToast(context, 'please_choose_your_address_first'.tr(), "error");
        }
         else{
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
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 8.h,
        padding:  EdgeInsetsDirectional.all(1.h),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(color: MyColors.Dark5, width: 1.0,),
            color: Colors.white),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() => dropOffController.finalDropOffTime.value!=""?
            Text(dropOffController.finalDropOffTime.value,
              style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_regular',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark3),
            )
                :Text('drop_off_date2'.tr(),
              style:  TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_regular',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark3),
            )),
            Spacer(),
            Transform.rotate(
                angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
                child: SvgPicture.asset('assets/arrow_right.svg',)),
          ],
        ),
      ),
    );
  }

  Widget bottomContent(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          /*InkWell(
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
                      child: ChoosePyment()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/card.svg',width: 4.h,height: 4.h),
                 SizedBox(width: 1.h,),
                Text('payment_method'.tr(), style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_light',
                    fontWeight: FontWeight.w300,
                    color: MyColors.Dark2)),
                Spacer(),
                Obx(() => createOrderController.payment.value!=""?
                Text(createOrderController.payment.value,
                        style: TextStyle(
                            fontSize: 9.sp,
                            fontFamily: 'lexend_light',
                            fontWeight: FontWeight.w300,
                            color: MyColors.MainColor))
                    : Text("",
                        style: TextStyle(
                            fontSize: 9.sp,
                            fontFamily: 'lexend_light',
                            fontWeight: FontWeight.w300,
                            color: MyColors.MainColor))),
                Transform.rotate(
                    angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
                    child: SvgPicture.asset('assets/arrow_right.svg',)),
              ],
            ),
          ),*/
          Row(
            children: [
              Text(
                "${'total_price'.tr()} :",
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2),
              ),
              const Spacer(),
              Text(
                "${createOrderController.totalPrice.value}EGP",
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark1),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/refresh_square.svg'),
              SizedBox(width: 1.h,),
              Text(
                'weekly_laundry_loop'.tr(),
                style: TextStyle(
                    fontSize: 12.sp,
                    fontFamily: 'regular',
                    fontWeight: FontWeight.w300,
                    color: MyColors.Dark2),
              ),
              const Spacer(),
              Checkbox(
                activeColor: MyColors.MainColor,
                value: createOrderController.isChecked,
                onChanged: (value) {
                  setState(() {
                    createOrderController.isChecked = value!;
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 1.h,),
          InkWell(
            onTap: ()async{
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
                      child: AddPromotionalCode()));

            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/discount_circle.svg',width: 4.h,height: 4.h),
                SizedBox(width: 1.h,),
                Text('Add_promotional_code'.tr(), style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_light',
                    fontWeight: FontWeight.w300,
                    color: MyColors.Dark2)),
                Spacer(),
                Obx(()=>Text( createOrderController.promocode.value.toString(), style:  TextStyle(fontSize: 10.sp,
                    fontFamily: 'lexend_light',
                    fontWeight: FontWeight.w300,
                    color: MyColors.SecondryColor)))
              ],
            ),
          ),
          SizedBox(height: 1.h,),
          InkWell(
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
                      child: AddNote()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/note_2.svg',width: 4.h,height: 4.h,),
                SizedBox(width: 1.h,),
                Text('add_notes'.tr(), style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_light',
                    fontWeight: FontWeight.w300,
                    color: MyColors.Dark2)),
                Spacer(),
                Text( createOrderController.NotesAddressController.text, style:  TextStyle(fontSize: 10.sp,
                    fontFamily: 'lexend_light',
                    fontWeight: FontWeight.w300,
                    color: MyColors.SecondryColor))
              ],
            ),
          ),
          SizedBox(height: 3.h,),
          Center(
            child: Obx(() =>
                Visibility(
                    visible: createOrderController.isVisable
                        .value,
                    child: const CircularProgressIndicator(color: MyColors.MainColor,)
                )),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsetsDirectional.only(bottom: 1.h),
            height: 8.h,
            child: TextButton(
              style: flatButtonStyle,
              onPressed: () {
                validation();
              },
              child: Text('confirm_order'.tr(),
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w700,
                    color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }

  void validation(){
    if(createOrderController.typeOfOrder==null){
      ToastClass.showCustomToast(context, 'please_choose_order_type'.tr(), "error");
    }else if(createOrderController.addressId==null){
      ToastClass.showCustomToast(context, 'please_choose_your_address_first'.tr(), "error");
    }else if(dropOffController.finalDropOffTime.value==""){
      ToastClass.showCustomToast(context, 'please_select_date_and_time_first'.tr(), "error");
    }else{
      createOrderController.isVisable.value=true;
      //createOrderController.createOrder(context, pickUpController.finalPickupTime.value, dropOffController.finalDropOffTime.value);
    }
  }
}