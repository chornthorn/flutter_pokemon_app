import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/networks/http_client.dart';
import 'app/application/change_language/change_language_bloc.dart';
import 'app/application/change_theme/change_theme_bloc.dart';
import 'pokemon/shared/pokemon_service_locator.dart';

GetIt getIt = GetIt.instance;

Future<void> initializationDependencies() async {
  // third party services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton<Dio>(Dio.new);

  // service
  getIt.registerLazySingleton<HttpService>(() => HttpService(getIt()));

  // demo service

  getIt.registerSingletonAsync<DemoService>(
    () async => DemoService().init(),
  );

  // bloc
  getIt.registerFactory(() => ChangeThemeBloc(getIt()));
  getIt.registerFactory(() => ChangeLanguageBloc(getIt()));

  pokemonServiceLocator();
}

class DemoService {
  Future<DemoService> init() async {
    return Future.delayed(const Duration(milliseconds: 0), () {
      prints();
      return this;
    });
  }

  void prints() {
    print('Demo service is ready');
  }
}
