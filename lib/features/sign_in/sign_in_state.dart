abstract class SignInState {}

class SignInInitialState extends SignInState{}
class SignInLoadingState extends SignInState{}
class SignInSuccessState extends SignInState{}
class SignInErrorState extends SignInState{
  SignInErrorState(String string);
}