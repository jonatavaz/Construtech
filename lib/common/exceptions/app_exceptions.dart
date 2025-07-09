abstract class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => 'AppException: $message' + (code != null ? ' (Code: $code)' : '');
}

class WeakPasswordException extends AppException {
  WeakPasswordException([String message = 'A senha é muito fraca. Por favor, use uma senha mais segura.'])
      : super(message, code: 'weak_password');
}

class SignUpFailedException extends AppException {
  SignUpFailedException([String message = 'Não foi possível criar a conta. Tente novamente mais tarde.'])
      : super(message, code: 'sign_up_failed');
}

class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException([String message = 'Este e-mail já está em uso. Por favor, use outro e-mail.'])
      : super(message, code: 'email_already_in_use');
}
