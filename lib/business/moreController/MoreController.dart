
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/socialModel/SocialResponse.dart';
import '../../data/model/updateTokenModel/UpdateTokenResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class MoreController extends GetxController {
  Repo repo = Repo(WebService());
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  var name, pic,phone;
  var updateTokenResponse = UpdateTokenResponse().obs;
  var socialResponse = SocialResponse().obs;
  var isLoading = false.obs;

  getData()async{
    name=sharedPreferencesService.getString("fullName")??"";
    pic=sharedPreferencesService.getString("picture")??"";
    phone=sharedPreferencesService.getString("phone_number")??"";
    getSocialLinks();
  }

  updateToken(BuildContext context) async {
    updateTokenResponse.value = (await repo.UpdateToken(""))!;
    if(updateTokenResponse.value.success==true){
      sharedPreferencesService.setBool('islogin',false);
      Navigator.pushNamedAndRemoveUntil(context,'/',ModalRoute.withName('/'));
    }
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