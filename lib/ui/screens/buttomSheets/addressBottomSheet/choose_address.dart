import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/addressListController/AddressListController.dart';
import '../../../../business/createOrderController/CreateOrderController.dart';
import '../../../../business/dropOffController/DropOffController.dart';
import '../../../../business/homeController/HomeController.dart';
import '../../../../business/pickUpController/PickUpController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget/AdressItem.dart';

class ChooseAddress extends StatefulWidget{
  var from;

  ChooseAddress({required this.from});

  @override
  State<StatefulWidget> createState() {
    return _ChooseAddress();
  }
}

class _ChooseAddress extends State<ChooseAddress>{
  var selectedFlageTime;
  final addressListController = Get.put(AddressListController());
  final homeController = Get.put(HomeController());
  final createOrderController = Get.put(CreateOrderController());
  final pickUpController = Get.put(PickUpController());
  final dropOffController = Get.put(DropOffController());
  @override
  void initState() {
    addressListController.getAddressList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.h,left: 2.h,top: 1.h,bottom: 1.h),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomBar(),
             SizedBox(
                width: MediaQuery.of(context).size.width,
                  height: 37.h,
                child: Obx(() => !addressListController.isLoading.value?AddressList()
                    :const Center(child: CircularProgressIndicator(color: MyColors.MainColor,),))
            ),
            SizedBox(height: 2.h,),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/location_screen',arguments: "listAddress");
              },
              child: Text(widget.from=="newOrder"?'add_new_address'.tr():'manage_your_address'.tr(),
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w400,
                    color: MyColors.MainColor),
              ),
            )
          ],
        ),
      ),
    );
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
              Text(widget.from=="newOrder"?'pick_up_location'.tr():'choose_your_delivery'.tr(),
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w700,
                    color: MyColors.Dark1),
              ),
              const Spacer(),
              IconButton(iconSize: 3.h,
                  icon: const Icon(Icons.close),
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

  Widget AddressList(){
    if(addressListController.addressList.isNotEmpty){
      return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: addressListController.addressList.length,
        itemBuilder: (BuildContext context, int index) {
          if(widget.from=="home"){
            return AddressItem(
                is_selected: selectedFlageTime==index,
                onTap: () {
                  setState(() {
                    selectedFlageTime=index;
                    homeController.currentAddress=addressListController.addressListResponse.value.data![index].streetName??"";
                    homeController.lat=double.parse(addressListController.addressListResponse.value.data![index].lat!);
                    homeController.lng=double.parse(addressListController.addressListResponse.value.data![index].lng!);
                    homeController.getHomeData();
                    Navigator.pop(context);
                  });
                },
                address: addressListController.addressList[index]
            );
          }else{
            return AddressItem(
                is_selected: selectedFlageTime==index,
                onTap: () {
                  if(widget.from=="newOrder"){
                    setState(() {
                      selectedFlageTime=index;
                      createOrderController.addressId=addressListController.addressListResponse.value.data![index].id;
                      createOrderController.lat=addressListController.addressListResponse.value.data![index].lat;
                      createOrderController.lng=addressListController.addressListResponse.value.data![index].lng;
                      createOrderController.streetName.value=addressListController.addressListResponse.value.data![index].streetName!;
                      createOrderController.getProducts(context).then((_){
                        createOrderController.offerId=0;
                        createOrderController.payment.value="";
                        createOrderController.CopunID="";
                        createOrderController.codeController.clear();
                        createOrderController.promocode.value="";
                        pickUpController.PickDate="";
                        pickUpController.PickDateHours="";
                        dropOffController.dropDate="";
                        dropOffController.dropDateHours="";
                        createOrderController.totalPrice.value=0;
                        createOrderController.totalAfterDiscount.value=0;
                        createOrderController.itemPrices=[];
                        createOrderController.quantityList.value=0;
                        createOrderController.cartItem.clear();
                        createOrderController.discount.value=0.0;
                        createOrderController.itemPrices2.clear();
                      });
                      Navigator.pop(context);
                    });
                  }else{
                    setState(() {
                      selectedFlageTime=index;
                      Navigator.pop(context);
                    });
                  }
                },
                address: addressListController.addressList[index]
            );
          }
        },
      );
    }else{
      return empty();
    }

  }
}

class empty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset('assets/no_locations.svg'),
            //SizedBox(height: 10,),
            Text('there_are_no_address'.tr(),
              style: TextStyle(fontSize: 14.sp,
                  fontFamily: 'lexend_bold',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5,),
            Text('your_address_will_appear_here'.tr(),
              style: TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_bold',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}