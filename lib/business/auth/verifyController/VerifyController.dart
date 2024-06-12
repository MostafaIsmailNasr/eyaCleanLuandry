import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:EyaCleanLaundry/ui/screens/drowerMenu/drower.dart';

import '../../../conustant/di.dart';
import '../../../conustant/shared_preference_serv.dart';
import '../../../data/model/auth/loginModel/LoginResponse.dart';
import '../../../data/model/auth/verifyModel/VerifyCodeResponse.dart';
import '../../../data/model/auth/verifyModel/resendModel/ResendCodeResponse.dart';
import '../../../data/reposatory/repo.dart';
import '../../../data/web_service/WebServices.dart';
import '../../../ui/screens/auth/createAccount/create_account_screen.dart';
import '../../../ui/screens/auth/verifyCode/Verfiy_code_screen.dart';

class VerifyController extends GetxController {
  Repo repo = Repo(WebService());
  var verifyCodeResponse = VerifyCodeResponse().obs;
  var resendCodeResponse = ResendCodeResponse().obs;
  var isLoading = false.obs;
  Rx<bool> isVisable = false.obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();

  var phone;
  var currentPin="";

  getphone()async{
    phone=sharedPreferencesService.getString("phone_number");
  }

  verify(BuildContext context,String currentPin) async {
    verifyCodeResponse.value = await repo.verifyCode(currentPin);
    if (verifyCodeResponse.value.success == true) {
      if(sharedPreferencesService.getInt("verfiyStatus")==1){
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) =>  DrowerPage(index: 0),
          ),
        );
      }else{
        // Navigator.pushReplacement<void, void>(
        //   context,
        //   MaterialPageRoute<void>(
        //     builder: (BuildContext context) =>  CreateAccountScreen(),
        //   ),
        // );
        Navigator.pushNamedAndRemoveUntil(context,'/create_account_screen',ModalRoute.withName('/create_account_screen'));
      }
      // verfiyCodeController.clear();
      currentPin="";
    } else {
      print(verifyCodeResponse.value.message);
      // verfiyCodeController.clear();
      currentPin="";
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(verifyCodeResponse.value.message.toString()),
        ),
      );
    }
  }

  resendCode(BuildContext context) async {
    resendCodeResponse.value = await repo.resendCode();
    if (resendCodeResponse.value.success == true) {
      Fluttertoast.showToast(
        msg: resendCodeResponse.value.data!.code!.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
      );
      // verfiyCodeController.clear();
       isVisable.value = false;
    } else {
      print(verifyCodeResponse.value.message);
       isVisable.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(verifyCodeResponse.value.message.toString()),
        ),
      );
    }
  }
}