abstract class HomeFormState {}

class HomeFormInitialState extends HomeFormState{}
class HomeFormLoadingState extends HomeFormState{}
class HomeFormSuccessState extends HomeFormState{}
class HomeFormErrorState extends HomeFormState{
  final String message;

  HomeFormErrorState(this.message);
}