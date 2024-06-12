
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/model/aboutAsModel/AboutAsResponse.dart';
import '../../data/model/socialModel/SocialResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class AboutUsController extends GetxController {
  Repo repo = Repo(WebService());
  var aboutAsResponse = AboutAsResponse().obs;
  var socialResponse = SocialResponse().obs;
  var isLoading = false.obs;

  aboutUs()async{
    isLoading.value=true;
    aboutAsResponse.value = await repo.aboutUs();
    if(aboutAsResponse.value.success==true){
      getSocialLinks();
      isLoading.value=false;
    }
    return aboutAsResponse.value;
  }

  getSocialLinks()async{
    isLoading.value=true;
    socialResponse.value = await repo.getSocialLinks();
    if(socialResponse.value.success==true){
      isLoading.value=false;
    }
    return socialResponse.value;
  }

}