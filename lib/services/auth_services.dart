import 'package:construtech/common/models/pessoa.dart';
import 'package:construtech/common/models/usuario.dart';

abstract class AuthServices {
  Future<Pessoa> signUp({
    String? Nome,
    required String Email,
    required String Senha,
  });
  Future signIn();
}
