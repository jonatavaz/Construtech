abstract class PaymentsFormState {}

class PaymentsFormInitialState extends PaymentsFormState{}
class PaymentsFormLoadingState extends PaymentsFormState{}
class PaymentsFormSuccessState extends PaymentsFormState{}
class PaymentsFormErrorState extends PaymentsFormState{
  final String message;

  PaymentsFormErrorState(this.message);
}