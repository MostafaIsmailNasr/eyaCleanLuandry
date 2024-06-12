
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/walletCodeModel/WalletCodeResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class ShareCodeController extends GetxController {
  Repo repo = Repo(WebService());
  var walletCodeResponse = WalletCodeResponse().obs;
  var isLoading = false.obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  var referCode;

  getWalletCodeData()async{
    isLoading.value=true;
    referCode= sharedPreferencesService.getString("refer_code");
    walletCodeResponse.value = await repo.walletBallanceCode();
    if(walletCodeResponse.value.success==true){
      isLoading.value=false;
    }
    return walletCodeResponse.value;
  }
}