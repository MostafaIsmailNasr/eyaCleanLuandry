import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/auth/createUserModel/CompleteUserInfoResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../../ui/screens/drowerMenu/drower.dart';
import '../../ui/screens/more/more_screen.dart';
import '../moreController/MoreController.dart';

class ProfileController extends GetxController {
  Repo repo = Repo(WebService());
  var profileResponse = CompleteUserInfoResponse().obs;
  var isLoading = false.obs;
  var errorMessage = "";
  var name;
  var pic;
  var phone;
  var email;
  File? image;
  Rx<bool> isVisabl = false.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  final moreController = Get.put(MoreController());



  profile(BuildContext context) async {
    profileResponse.value = await repo.updateProfile(
      image,
        nameController.text,
        emailController.text,
        PhoneController.text,);
    if (profileResponse.value.success == true) {
      isVisabl.value = false;
      sharedPreferencesService.setString('fullName', profileResponse.value.data!.name??"");
       sharedPreferencesService.setString('picture', profileResponse.value.data!.avatar??"");
       //sharedPreferencesService.setString('phone_number', profileResponse.value.data!.mobile??"");
      sharedPreferencesService.setString('phone_number', profileResponse.value.data!.mobile??"");
      print("phooo2"+ profileResponse.value.data!.mobile!);
      sharedPreferencesService.setString('email', profileResponse.value.data!.email??"");
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
            return DrowerPage(index: 0,);
          }));
      image=null;
      //Navigator.pop(context);
    } else {
      isVisabl.value = false;
      if(profileResponse.value.message==null){
        ScaffoldMessenger.of(context!).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text("Wrong Email"),
          ),
        );
      }else{
        ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(profileResponse.value.message.toString()),
          ),
        );
      }
    }
  }

}