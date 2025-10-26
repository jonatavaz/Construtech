class Validator {
  Validator._();

  static String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Você deve digitar seu nome.";
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value!.isEmpty) {
      return "Você deve digitar seu e-mail.";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    final condition = RegExp(
      r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$",
    );
    if (value!.isEmpty) {
      return "Você deve digitar sua senha.";
    }
    if (value != null && condition.hasMatch(value)) {
      return "Senha inválida. Digite uma senha válida.";
    }

    return null;
  }

  static String? validateConfirmPassword(String? one, String? two) {
    if (one != two) {
      return "As senhas não coincidem";
    }

    return null;
  }
}
