import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/toast_class.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

import '../../conustant/di.dart';
import '../../conustant/my_colors.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/NoonModel/NoonRespone.dart';
import '../../data/model/UpdateStatusModel/UpdateStatusResponse.dart';
import '../../data/model/addressModel/addAddressModel/AddAddressResponse.dart';
import '../../data/model/addressModel/addressListModel/AddressListResponse.dart';
import '../../data/model/copunModel/CopunResponse.dart';
import '../../data/model/createOrderModel/CreateOrderResponse.dart';
import '../../data/model/daySettingModel/DaySettingResponse.dart';
import '../../data/model/noonPaymentModel/NoonPaymentResponse.dart';
import '../../data/model/productCartModel/ProductCartResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/drowerMenu/drower.dart';
import '../dropOffController/DropOffController.dart';
import '../homeController/HomeController.dart';
import '../pickUpController/PickUpController.dart';

class CreateOrderController extends GetxController {
  Repo repo = Repo(WebService());

  var createOrderResponse = CreateOrderResponse().obs;
  var noonPaymentResponse = NoonPaymentResponse().obs;
  var noonRespone = NoonRespone().obs;
  var copunResponse2 = copunResponse().obs;
  var daySettingResponse = DaySettingResponse().obs;
  var addAddressResponse = AddAddressResponse().obs;
  var addressListResponse = AddressListResponse().obs;
  var productCartResponse = ProductCartResponse().obs;
  var updateStatusResponse = UpdateStatusResponse().obs;
  var isLoading = false.obs;
  var isLoading2 = false.obs;
  var isLoading3 = false.obs;
  Rx<bool> isVisable = false.obs;
  Rx<bool> btnVisable = false.obs;
  RxList<dynamic> addressList=[].obs;
  RxList<dynamic> productList=[].obs;
  bool isChecked = false;
  var quantityList=0.obs;
  RxMap<int, int> itemPrices2 = RxMap<int, int>();

  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  var typeOfOrder;
  var addressId;
  var lat;
  var lng;
  var streetName="".obs;
  var payment="".obs;
  var offerId;
  var CopunID;
  var promocode="".obs;
  List<int> itemPrices = [];
  List<Products> cartItem = [];
  var totalPrice=0.obs;
  Rx<String> productsJson="".obs;
  Rx<int> quntity=0.obs;
  Rx<int> quntity2=0.obs;
  var discount=0.0.obs;
  var totalAfterDiscount=0.0.obs;
  var amountTabby=0.0.obs;
  var keyWeeklyLoop=0.obs;
  //taby//
  String status = 'idle';
  TabbySession? session;
  //noon//
  Rx<String> noonLink="".obs;
  var type="";


  TextEditingController codeController = TextEditingController();
  TextEditingController NotesAddressController=TextEditingController();
  final homeController = Get.put(HomeController());

  void setItemPrice(int productId, int price) {
    itemPrices2[productId] = price;
  }
  int getItemPrice(int productId) {
    return itemPrices2[productId] ?? 0;
  }

  // int calculateTotalPrice() {
  //    totalPrice.value = itemPrices.fold(0, (prev, price) => prev + price);
  //    totalAfterDiscount.value = totalPrice.value.toDouble();
  //   return totalPrice.value;
  // }

  createOrder(
      BuildContext context,
      String deliveryDate,
      String receivedDate,
      ) async {
    createOrderResponse.value = await repo.createOrder(
         addressId,
        CopunID??0,
         offerId??0,
        typeOfOrder,
         deliveryDate,
         receivedDate,
        payment.value,
        NotesAddressController.text,
        productsJson.value,
        keyWeeklyLoop.value,
      totalPrice.value,
      totalAfterDiscount.value,
      discount.value,
      promocode.value
    );
    if (createOrderResponse.value.success == true) {
      isVisable.value=false;
      //_onAlertButtonsPressed(context);
      if(payment.value=="cash"){
        offerId=0;
        lng="";
        lat="";
        streetName.value="";
        payment.value="";
        typeOfOrder="";
        CopunID=null;
        codeController.clear();
        promocode.value="";
        cartItem.clear();
        discount.value=0.0;
        totalPrice.value=0;
        itemPrices=[];
        quantityList.value=0;
        itemPrices2.clear();
      }
      sharedPreferencesService.setInt("orderId",createOrderResponse.value.data!.id!);
    } else {
      isVisable.value=false;
      print(createOrderResponse.value.message);
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(createOrderResponse.value.message.toString()),
        ),
      );
    }
  }

  validateCopune(BuildContext context)async{
    isLoading2.value=true;
    copunResponse2.value = await repo.validateCoupon(codeController.text);
    if(copunResponse2.value.success==true){
      isVisable.value=false;
      btnVisable.value=true;
      isLoading2.value=false;
      promocode.value=codeController.text;
      CopunID=copunResponse2.value.data!.id;

      if(copunResponse2.value.data?.type=="fixed"
          &&(copunResponse2.value.data!.value!.toInt())<=totalPrice.value){
        discount.value=copunResponse2.value.data!.value!.toDouble();
        totalAfterDiscount.value=(totalPrice.value-discount.value) ;
      }else if(copunResponse2.value.data?.type=="percentage"){
        discount.value=(totalPrice.value*((copunResponse2.value.data!.value!)/100)) ;
        totalAfterDiscount.value=(totalPrice.value-discount.value) ;
      }
      Navigator.pop(context);
      ToastClass.showCustomToast(context, "Success", "sucess");
      codeController.clear();
    }else{
      isVisable.value=false;
      btnVisable.value=true;
      codeController.clear();
      // promocode.value="";
      ToastClass.showCustomToast(context, copunResponse2.value.message, "error");
    }
    return copunResponse2.value;
  }

  getOrderDays(BuildContext context)async{
    isLoading3.value=true;
    daySettingResponse.value = await repo.getOrderDays();
    if(daySettingResponse.value.success==true){
      isLoading3.value=false;
    }else{
      isLoading3.value=false;
      ToastClass.showCustomToast(context, daySettingResponse.value.message, "error");
    }
    return daySettingResponse.value;
  }

  onAlertButtonsPressed(context) {
    Alert(
      context: context,
      image: SvgPicture.asset('assets/checked.svg',width: 7.h,height: 7.h,),
      title: 'congratulations'.tr(),
      style:  AlertStyle(
          titleStyle:TextStyle(fontSize: 16.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w800,
              color: MyColors.Dark1),
          descStyle: TextStyle(fontSize: 16.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w800,
              color: MyColors.Dark1)
      ),
      desc: 'the_order_was_made_successfully'.tr(),
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(50),
          height: 7.h,
          onPressed: ()  {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return DrowerPage(index: 0,);
                }));
            //Navigator.pushNamed(context, '/drower')
          },
          color: MyColors.MainColor,
          child: Text('home'.tr(), style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white)),
        ),
        DialogButton(
          height: 7.h,
          radius: BorderRadius.circular(50),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) {
                  return DrowerPage(index: 2,);
                }));
            // Navigator.pushNamed(context, '/my_orders_screen');
          },
          color: MyColors.MainColor2,
          child: Text('my_orders'.tr(), style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white)),

        )
      ],
    ).show();
  }

  getAddressList(BuildContext context)async{
    isLoading.value=true;
    //userName=sharedPreferencesService.getString("fullName");
    addressListResponse.value = await repo.getAddress();
    if(addressListResponse.value.success==true){
      isLoading.value=false;
      addressList.value=addressListResponse.value.data as List;
      if(addressListResponse.value.data!.isEmpty){
        print("innn");
        lat=homeController.lat;
        lng=homeController.lng;
        streetName.value=homeController.currentAddress;
        addAddress(context);
      }else{
        lat=addressListResponse.value.data?[0].lat;
        lng=addressListResponse.value.data?[0].lng;
        streetName.value=addressListResponse.value.data?[0].streetName??"";
        addressId=addressListResponse.value.data?[0].id;
      }
      print("outtt");
      getProducts(context);

    }
    return addressListResponse.value;
  }

  addAddress(BuildContext context) async {
    addAddressResponse.value = await repo.addAddress(streetName.value,lat.toString(),lng.toString(),"home");
    if (addAddressResponse.value.success == true) {
      // isVisable.value = false;
      lat=addAddressResponse.value.data?.lat;
      lng=addAddressResponse.value.data?.lng;
      streetName.value=addAddressResponse.value.data?.streetName??"";
      addressId=addAddressResponse.value.data?.id;
     //addressId=addAddressResponse.value.data?.id;
    } else {
      isVisable.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(addAddressResponse.value.message??""),
        ),
      );
    }
  }

  getProducts(BuildContext context)async{
    isLoading.value=true;
    productCartResponse.value = await repo.getProducts(lat.toString(), lng.toString());
    if(productCartResponse.value.success==true){
      productList.value=productCartResponse.value.data!.products!;
      isLoading.value=false;
    }else{
      isLoading.value=false;
      // ignore: use_build_context_synchronously
      ToastClass.showCustomToast(context, productCartResponse.value.message??"", "error");
    }
    return productCartResponse.value;
  }

  String convertProductListToJson(List<Products> productsList) {
    List<Map<String, dynamic>> productListJson = [];
      productsList.forEach((product) {
      productListJson.add({
        'id': product.id, // Replace with your product ID field
        'price':typeOfOrder=="normal"? product.regularPrice ?? 0:product.urgentPrice ?? 0, // Replace with your product price field
        'quantity': product.quantity, // Add a quantity field to your Products model
      });
    });
    return jsonEncode(productListJson);
  }

  paymentNoon(BuildContext context)async{
    noonPaymentResponse.value = await repo.noonPayment(totalAfterDiscount.value,);
    if(noonPaymentResponse.value.resultCode==0&&noonPaymentResponse.value.message=="Processed successfully"){
      isVisable.value=false;
      noonLink.value=noonPaymentResponse.value.result!.checkoutData!.postUrl!;
    }else{
      isVisable.value=false;
      print(createOrderResponse.value.message);
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(noonPaymentResponse.value.message.toString()),
        ),
      );
    }
  }


  noonCallBack(String orderId)async{
    noonRespone.value = await repo.noonCallBack(orderId,);
  }


  updateStatus(BuildContext context,String Stu,String transaction_id)async{
    //isLoading.value=true;
    updateStatusResponse.value = await repo.updateOrderStatus(createOrderResponse.value.data!.id!, Stu,transaction_id);
    if(updateStatusResponse.value.success==true){
      //isLoading.value=false;
      if(payment.value=="tabby"){
        updatePaymentStatus(context,"paid","");
      }
      onAlertButtonsPressed(context);
    }else{
      isLoading.value=false;
      // ignore: use_build_context_synchronously
      ToastClass.showCustomToast(context, productCartResponse.value.message??"", "error");
    }
    return updateStatusResponse.value;
  }

  updateStatus2(String Stu,String transaction_id)async{
    updateStatusResponse.value = await repo.updateOrderStatus(createOrderResponse.value.data!.id!, Stu,transaction_id);
    return updateStatusResponse.value;
  }

  updatePaymentStatus(BuildContext context,String Stu,String transaction_id)async{
    //isLoading.value=true;
    updateStatusResponse.value = await repo.updatePaymentStatus(createOrderResponse.value.data!.id!, Stu,transaction_id);
    if(updateStatusResponse.value.success==true){
    }else{
      isLoading.value=false;
      // ignore: use_build_context_synchronously
      ToastClass.showCustomToast(context, updateStatusResponse.value.message??"", "error");
    }
    return updateStatusResponse.value;
  }

}