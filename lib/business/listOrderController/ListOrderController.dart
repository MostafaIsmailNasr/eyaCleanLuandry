import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/toast_class.dart';
import '../../data/model/ListOrderModel/ListOrderResponse.dart';
import '../../data/model/addressModel/deleteModel/DeleteResponse.dart';
import '../../data/model/rateOrderModel/RateOrderResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class ListOrdersController extends GetxController {
  Repo repo = Repo(WebService());
  var listOrderResponse = ListOrderResponse().obs;
  var deleteResponse = DeleteResponse().obs;
  var rateOrderResponse = RateOrderResponse().obs;
  Rx<bool> isVisable = false.obs;
  RxList<dynamic> orderList=[].obs;
  var isLoading = false.obs;
  TextEditingController NotesController=TextEditingController();
  double? orderRate = 0.0;
  double? driverRate = 0.0;

  getListOrders()async{
    isLoading.value=true;
    listOrderResponse.value = await repo.listOrders();
    if(listOrderResponse.value.success==true){
      isLoading.value=false;
      orderList.value=listOrderResponse.value.data as List;

    }
    return listOrderResponse.value;
  }

  cancelOrder(int orderId,BuildContext context)async{
    isLoading.value=true;
    deleteResponse.value = await repo.deleteOrder(orderId);
    if(deleteResponse.value.success==true){
      isLoading.value=false;
      Get.back();
      getListOrders();
      return deleteResponse.value;
    } else {
      isLoading.value=false;
      Get.back();
      ToastClass.showCustomToast(context, deleteResponse.value.message, 'error');
    }
    return listOrderResponse.value;
  }

  RateOrder(int orderId,BuildContext context)async{
    rateOrderResponse.value = await repo.rateOrder(orderId,orderRate.toString(),driverRate.toString(),NotesController.text);
    if(rateOrderResponse.value.success==true){
      isVisable.value=false;
      Get.back();
      getListOrders();
      NotesController.clear();
      orderRate=0.0;
      driverRate=0.0;
      return rateOrderResponse.value;
    } else {
      isVisable.value=false;
      //Get.back();
      ToastClass.showCustomToast(context, rateOrderResponse.value.message??"", 'error');
    }
    return listOrderResponse.value;
  }
}