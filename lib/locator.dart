import 'package:construtech/features/equipamento/equipamento_controller.dart';
import 'package:construtech/features/home/home_controller.dart';
import 'package:construtech/features/home/home_form_controller.dart';
import 'package:construtech/features/materials/materials_controller.dart';
import 'package:construtech/features/materials/materials_form_controller.dart';
import 'package:construtech/features/payments/forms/payments_form_controller.dart';
import 'package:construtech/features/payments/payments_controller.dart';
import 'package:construtech/features/sign_in/sign_in_controller.dart';
import 'package:construtech/features/sign_up/sign_up_controller.dart';
import 'package:construtech/services/auth_services.dart';
import 'package:construtech/services/mock_auth_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupDependences() {
  locator.registerLazySingleton<AuthServices>(() => MockAuthService());

  locator.registerFactory<SignInController>(() => SignInController());
  locator.registerFactory<SignUpController>(() => SignUpController());
  locator.registerFactory<HomeController>(() => HomeController());
  locator.registerFactory<HomeFormController>(() => HomeFormController());
  locator.registerFactory<MaterialsFormController>(
    () => MaterialsFormController(),
  );
  locator.registerFactory<EquipamentoController>(() => EquipamentoController());
  locator.registerFactory<MaterialsController>(() => MaterialsController());
  locator.registerFactory<PaymentsFormController>(() => PaymentsFormController());
  locator.registerFactory<PaymentsController>(() => PaymentsController());
}
