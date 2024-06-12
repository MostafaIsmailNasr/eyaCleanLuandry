
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';

class ChangeLanguageController extends GetxController {
  Repo repo = Repo(WebService());
  var lang="";
  late double lat=30.0622723;
  late double lng=31.3274007;
}