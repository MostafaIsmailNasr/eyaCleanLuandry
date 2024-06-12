
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../data/model/walletModel/WalletResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class WalletBalanceController extends GetxController {
  Repo repo = Repo(WebService());
  var walletResponse = WalletResponse().obs;
  var isLoading = false.obs;
  RxList<dynamic> walletList = [].obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();

  getWalletData()async{
    isLoading.value=true;
    walletResponse.value = await repo.walletBallance();
    if(walletResponse.value.success==true){
      isLoading.value=false;
      walletList.value=walletResponse.value.data!.walletTransactions as List;
    }
    return walletResponse.value;
  }
}