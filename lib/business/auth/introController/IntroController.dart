import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../data/model/auth/introModel/IntroResponse.dart';
import '../../../data/reposatory/repo.dart';
import '../../../data/web_service/WebServices.dart';

class IntroController extends GetxController {
  Repo repo = Repo(WebService());
  var introResponse = IntroResponse().obs;
  RxList<dynamic> introList=[].obs;
  var isLoading=false.obs;

  getIntroData()async{
    //final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoading.value=true;
    introResponse.value = await repo.getIntro();
    introList.value=introResponse.value.data??[] as List;
    isLoading.value=false;
    return introResponse.value;
  }
}