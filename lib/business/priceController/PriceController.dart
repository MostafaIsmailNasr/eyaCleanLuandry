import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/priceModel/PriceResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../homeController/HomeController.dart';

class PriceController extends GetxController {
  Repo repo = Repo(WebService());
  var priceResponse = PriceResponse().obs;
  var isLoading = false.obs;
   RxList<dynamic> tapsCatList=[].obs;
   RxList<dynamic> subCatList=[].obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  final homeController = Get.put(HomeController());

  getPriceData()async{
    isLoading.value=true;
    priceResponse.value = await repo.getPriceData(homeController.lat, homeController.lng);
    if(priceResponse.value.success==true){
      isLoading.value=false;
      tapsCatList.value=priceResponse.value.data as List;
    }
    return priceResponse.value;
  }
}