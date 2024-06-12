import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/offersModel/OffersResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../homeController/HomeController.dart';

class OfferController extends GetxController {
  Repo repo = Repo(WebService());
  var offersResponse = OffersResponse().obs;
  var isLoading = false.obs;
  RxList<dynamic> offersList = [].obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  final homeController = Get.put(HomeController());

  getOffersData()async{
    isLoading.value=true;
    offersResponse.value = await repo.getOffersData(homeController.lat, homeController.lng);
    if(offersResponse.value.success==true){
      isLoading.value=false;
      offersList.value=offersResponse.value.data as List;
    }
    return offersResponse.value;
  }
}