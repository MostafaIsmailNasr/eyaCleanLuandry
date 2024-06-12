import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../conustant/di.dart';
import '../../../conustant/shared_preference_serv.dart';
import '../../../data/model/auth/loginModel/LoginResponse.dart';
import '../../../data/model/updateTokenModel/UpdateTokenResponse.dart';
import '../../../data/reposatory/repo.dart';
import '../../../data/web_service/WebServices.dart';
import '../../../ui/screens/auth/verifyCode/Verfiy_code_screen.dart';

class LoginController extends GetxController {
  Repo repo = Repo(WebService());
  var loginResponse = LoginResponse().obs;
  var updateTokenResponse = UpdateTokenResponse().obs;
  var isLoading = false.obs;
  Rx<bool> isVisable = false.obs;
  bool isLogin = false;
  var token = "";
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController shareCodeController = TextEditingController();

  @override
  void onInit() async {
    getToken();
    super.onInit();
  }

  void getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    print("tokeen is " + token!);
    FirebaseMessaging.instance.onTokenRefresh
        .listen((fcmToken) {
      print(fcmToken);
    })
        .onError((err) {
      print("Error getting token");
    });
  }

  loginUse(BuildContext context) async {
    loginResponse.value = await repo.login(PhoneController.text,shareCodeController.text);
    if (loginResponse.value.success == true) {
      isLogin=true;
      sharedPreferencesService.setBool("islogin", isLogin);
       sharedPreferencesService.setInt('id', loginResponse.value.data!.id!);
       sharedPreferencesService.setString('phone_number', loginResponse.value.data!.mobile!);
      sharedPreferencesService.setString('picture', loginResponse.value.data!.avatar??"");
      sharedPreferencesService.setString('fullName', loginResponse.value.data!.name??"");
      sharedPreferencesService.setString('email', loginResponse.value.data!.email??"");
       sharedPreferencesService.setString('tokenUser', loginResponse.value.data!.token!);
      sharedPreferencesService.setString('refer_code', loginResponse.value.data!.referCode!);
      sharedPreferencesService.setInt('verfiyStatus', loginResponse.value.data!.status!);
      print("tokkk222/"+loginResponse.value.data!.token!);
       sharedPreferencesService.setString('role', loginResponse.value.data!.role!);
      await updateToken();
       if(PhoneController.text=="8665562566"){
         Navigator.pushNamedAndRemoveUntil(context,'/drower',ModalRoute.withName('/drower'));
       }else{
         if(loginResponse.value.data!.role=="user"){
           isVisable.value = false;
           Navigator.pushNamed(context, "/Verfiy_code_screen",arguments:loginResponse.value.data!.code!);
         }else{
           isVisable.value = false;
           ScaffoldMessenger.of(context!).showSnackBar(
             SnackBar(
               backgroundColor: Colors.red,
               content: Text('data_isnt_for_driver'.tr()),
             ),
           );
         }
       }

      PhoneController.clear();
       shareCodeController.clear();
      isVisable.value = false;
    } else {
      isVisable.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(loginResponse.value.message!),
        ),
      );
    }
    //print("object222" + lang);
  }
  updateToken() async {
    updateTokenResponse.value = (await repo.UpdateToken(token))!;
  }
}