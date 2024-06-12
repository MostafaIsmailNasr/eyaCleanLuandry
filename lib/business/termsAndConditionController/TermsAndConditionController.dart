
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/TermsAndConditionsModel/TermsAndConditionsResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class TermsAndConditionController extends GetxController {
  Repo repo = Repo(WebService());
  var termsAndConditionsResponse = TermsAndConditionsResponse().obs;
  var isLoading = false.obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();

  getTermsAndConditions()async{
    isLoading.value=true;
    termsAndConditionsResponse.value = await repo.termsAndCondition();
    if(termsAndConditionsResponse.value.success==true){
      isLoading.value=false;
    }
    return termsAndConditionsResponse.value;
  }
}