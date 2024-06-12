import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/homeModel/HomeResponse.dart';
import '../../data/model/socialModel/SocialResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class HomeController extends GetxController {
  Repo repo = Repo(WebService());
  var homeResponse = HomeResponse().obs;
  var isLoading = false.obs;
  RxList<dynamic> sliderList=[].obs;
  RxList<dynamic> offersList=[].obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  String currentAddress = '';
  late double lat=30.0622723;
  late double lng=31.3274007;
  var profileImg;
  var profileName;
  var socialResponse = SocialResponse().obs;

  getData()async{
    profileImg=sharedPreferencesService.getString("picture");
    profileName=sharedPreferencesService.getString("fullName");
  }

  getHomeData()async{
    isLoading.value=true;
    getData();
      homeResponse.value = await repo.getHomeData(lat, lng);
      if(homeResponse.value.success==true){
        isLoading.value=false;
        sliderList.value=homeResponse.value.data?.sliders as List;
        offersList.value=homeResponse.value.data?.offers as List;
        getSocialLinks();
      }
      return homeResponse.value;


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