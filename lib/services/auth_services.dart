import 'package:construtech/models/pessoa.dart';
import 'package:construtech/models/usuario.dart';

abstract class AuthServices {
  Future<Pessoa> signUp({
    String? Nome,
    required String Email,
    required String Senha,
  });
  Future<Pessoa> signIn({required String Email, required String Senha});

  Future<void> signOut();
}
