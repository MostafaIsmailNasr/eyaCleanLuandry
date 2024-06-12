import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../conustant/toast_class.dart';
import '../../data/model/hoursModel/HoursResponse.dart';
import '../../data/model/pickupDateModel/PickupDateResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../createOrderController/CreateOrderController.dart';

class PickUpController extends GetxController {
  Repo repo = Repo(WebService());
  var pickupDateResponse = PickupDateResponse().obs;
  var hoursResponse = HoursResponse().obs;
  var isLoading = false.obs;
  var isLoading2 = false.obs;
  RxList<dynamic> pickUpDateList = [].obs;
  RxList<dynamic> pickUpHoursList = [].obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  var PickDate;
  var PickDateHours;
  var finalPickupTime="".obs;
  final createOrderController = Get.put(CreateOrderController());

  getPickUpDates(BuildContext context)async{
    isLoading.value=true;
    pickupDateResponse.value = await repo.getPickupDate();
    if(pickupDateResponse.value.success==true){
      isLoading.value=false;
      pickUpDateList.value=pickupDateResponse.value.data as List;
      PickDate=pickupDateResponse.value.data![0].date!;
      getPickUpHoursDates2(pickupDateResponse.value.data![0].date!,context);
    }
    return pickupDateResponse.value;
  }

  getPickUpHoursDates(BuildContext context)async{
    isLoading2.value=true;
    hoursResponse.value = await repo.getHours(PickDate, createOrderController.addressId, "delivery");
    if(hoursResponse.value.success==true){
      isLoading2.value=false;
      pickUpHoursList.value=hoursResponse.value.data as List;

    }else{
      isLoading2.value=false;
      ToastClass.showCustomToast(context, hoursResponse.value.message, "error");
    }
    return hoursResponse.value;
  }

  getPickUpHoursDates2(String PickDate2,BuildContext context)async{
    isLoading2.value=true;
    hoursResponse.value = await repo.getHours(PickDate2, createOrderController.addressId, "delivery");
    if(hoursResponse.value.success==true){
      isLoading2.value=false;
      pickUpHoursList.value=hoursResponse.value.data as List;
    }else{
      isLoading2.value=false;
      ToastClass.showCustomToast(context, hoursResponse.value.message, "error");
    }
    return hoursResponse.value;
  }
}