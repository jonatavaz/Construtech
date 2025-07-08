abstract class PersonFormState {}

class PersonFormInitialState extends PersonFormState{}
class PersonFormLoadingState extends PersonFormState{}
class PersonFormSuccessState extends PersonFormState{}
class PersonFormErrorState extends PersonFormState{
  final String message;

  PersonFormErrorState(this.message);
}