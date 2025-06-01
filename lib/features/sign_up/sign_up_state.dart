abstract class SignUpState {}

class SignUpInitialState extends SignUpState{}
class SignInLoadingState extends SignUpState{}
class SignInSuccessState extends SignUpState{}
class SignInErrorState extends SignUpState{
  final String message;

  SignInErrorState(this.message);
}