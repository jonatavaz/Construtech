import 'package:construtech/features/sign_in/sign_in_controller.dart';
import 'package:construtech/features/sign_up/sign_up_controller.dart';
import 'package:construtech/services/auth_services.dart';
import 'package:construtech/services/mock_auth_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependences() {
  locator.registerLazySingleton<AuthServices>(() => MockAuthService());

  locator.registerFactory<SignInController>(()=> SignInController(locator.get<AuthServices>()));
  locator.registerFactory<SignUpController>(()=> SignUpController(locator.get<AuthServices>()));
}
