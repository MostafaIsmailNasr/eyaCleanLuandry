import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:EyaCleanLaundry/conustant/shared_preference_serv.dart';


final instance = GetIt.instance;

Future<void> setupDependencyInjection() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);
  instance.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService(instance()));
}
