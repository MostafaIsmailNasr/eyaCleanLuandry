import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:EyaCleanLaundry/conustant/toast_class.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/dropOffDateModel/DropOffDateResponse.dart';
import '../../data/model/hoursModel/HoursResponse.dart';
import '../../data/model/pickupDateModel/PickupDateResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../createOrderController/CreateOrderController.dart';

class DropOffController extends GetxController {
  Repo repo = Repo(WebService());
  var dropOffDateResponse = DropOffDateResponse().obs;
  var hoursResponse = HoursResponse().obs;
  var isLoading = false.obs;
  var isLoading2 = false.obs;
  RxList<dynamic> dropOffDateList = [].obs;
  RxList<dynamic> dropOffHoursList = [].obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  var dropDate;
  var dropDateHours;
  var finalDropOffTime="".obs;
  final createOrderController = Get.put(CreateOrderController());

  getDropOffDates(String type,String date,BuildContext context)async{
    isLoading.value=true;
    dropOffDateResponse.value = await repo.getDropOffDate(type,date);
    if(dropOffDateResponse.value.success==true){
      isLoading.value=false;
      dropOffDateList.value=dropOffDateResponse.value.data as List;
      dropDate=dropOffDateResponse.value.data![0].date!;
      getPickUpHoursDates2(dropOffDateResponse.value.data![0].date!,context);
    }
    return dropOffDateResponse.value;
  }

  getPickUpHoursDates(BuildContext context)async{
    isLoading2.value=true;
    hoursResponse.value = await repo.getHours(dropDate, createOrderController.addressId, "received");
    if(hoursResponse.value.success==true){
      isLoading2.value=false;
      dropOffHoursList.value=hoursResponse.value.data as List;
    }else{
      isLoading2.value=false;
      ToastClass.showCustomToast(context, hoursResponse.value.message, "error");
    }
    return hoursResponse.value;
  }

  getPickUpHoursDates2(String dropDate2,BuildContext context)async{
    isLoading2.value=true;
    hoursResponse.value = await repo.getHours(dropDate2, createOrderController.addressId, "received");
    if(hoursResponse.value.success==true){
      isLoading2.value=false;
      dropOffHoursList.value=hoursResponse.value.data as List;
    }else{
      isLoading2.value=false;
      ToastClass.showCustomToast(context, hoursResponse.value.message, "error");
    }
    return hoursResponse.value;
  }
}