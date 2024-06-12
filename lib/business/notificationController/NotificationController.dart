import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/notificationModel/NotificationResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class NotificationController extends GetxController {
  Repo repo = Repo(WebService());
  var notificationResponse = NotificationResponse().obs;
  var isLoading = false.obs;
  RxList<dynamic> notificationList = [].obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();

  getNotificationData()async{
    isLoading.value=true;
    notificationResponse.value = await repo.getNotificationData();
    if(notificationResponse.value.success==true){
      isLoading.value=false;
      notificationList.value=notificationResponse.value.data as List??[];
    }
    return notificationResponse.value;
  }
}