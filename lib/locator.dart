import 'package:construtech/controllers/equipamento_controller.dart';
import 'package:construtech/controllers/home_controller.dart';
import 'package:construtech/controllers/home_form_controller.dart';
import 'package:construtech/controllers/materials_controller.dart';
import 'package:construtech/controllers/materials_form_controller.dart';
import 'package:construtech/controllers/payments_form_controller.dart';
import 'package:construtech/controllers/payments_controller.dart';
import 'package:construtech/controllers/person_form_controller.dart';
import 'package:construtech/controllers/person_controller.dart';
import 'package:construtech/controllers/sign_in_controller.dart';
import 'package:construtech/controllers/sign_up_controller.dart';
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
  locator.registerFactory<PaymentsFormController>(
    () => PaymentsFormController(),
  );
  locator.registerFactory<PaymentsController>(() => PaymentsController());
  locator.registerFactory<PersonFormController>(() => PersonFormController());
  locator.registerFactory<PersonController>(() => PersonController());
}
