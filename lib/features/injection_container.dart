import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'pokemon/shared/pokemon_service_locator.dart';

GetIt getIt = GetIt.instance;

Future<void> initializationDependencies() async {
  // third party services
  getIt.registerLazySingleton<Dio>(Dio.new);

  // demo service
  getIt.registerSingletonAsync<DemoService>(
    () async => DemoService().init(),
  );

  pokemonServiceLocator();
}

class DemoService {
  Future<DemoService> init() async {
    return Future.delayed(const Duration(milliseconds: 2000), () {
      prints();
      return this;
    });
  }

  void prints() {
    print('Demo service is ready');
  }
}
