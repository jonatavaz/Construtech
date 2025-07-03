abstract class PaymentsState {}

class PaymentsInitialState extends PaymentsState{}
class PaymentsLoadingState extends PaymentsState{}
class PaymentsSuccessState extends PaymentsState{}
class PaymentsErrorState extends PaymentsState{
  final String message;

  PaymentsErrorState(this.message);
}