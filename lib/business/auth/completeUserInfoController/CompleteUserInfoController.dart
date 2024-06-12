import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../conustant/di.dart';
import '../../../conustant/shared_preference_serv.dart';
import '../../../data/model/auth/createUserModel/CompleteUserInfoResponse.dart';
import '../../../data/reposatory/repo.dart';
import '../../../data/web_service/WebServices.dart';

class CompleteUserInfoController extends GetxController {
  Repo repo = Repo(WebService());
  var completeUserInfoResponse = CompleteUserInfoResponse().obs;
  var isLoading = false.obs;
  Rx<bool> isVisable = false.obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  File? image;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var lat;
  var lng;
  var address2="".obs;
  var type;



  completeUserInfo(BuildContext context) async {
    print("addd"+address2.toString());
    completeUserInfoResponse.value = await repo.CompleteUserInfo(
        image,nameController.text,
        address2.value?? "",
        type??"",lat??"",lng??"",emailController.text);
    if (completeUserInfoResponse.value.success == true) {
      sharedPreferencesService.setString('fullName', completeUserInfoResponse.value.data!.name!);
      sharedPreferencesService.setString('picture', completeUserInfoResponse.value.data!.avatar!);
      sharedPreferencesService.setString('email', completeUserInfoResponse.value.data!.email!);
      Navigator.pushNamedAndRemoveUntil(context,'/drower',ModalRoute.withName('/drower'));
      nameController.clear();
      emailController.clear();
      lat="";
      lng="";
      address2.value="";
      type="";
      image=null;
      isVisable.value = false;
    } else {
      print("oooor"+completeUserInfoResponse.value.message.toString());
      isVisable.value = false;
      if(completeUserInfoResponse.value.message==null){
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
            content: Text(completeUserInfoResponse.value.message.toString()),
          ),
        );
      }

    }
  }

}
