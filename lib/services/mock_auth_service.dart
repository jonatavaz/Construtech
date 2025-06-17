import 'package:construtech/common/models/pessoa.dart';
import 'package:construtech/services/auth_services.dart';
import 'package:construtech/services/mock_auth_service.dart' as _auth;

class MockAuthService implements AuthServices {
  @override
  Future<Pessoa> signIn({required String Email, required String Senha}) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      if (Senha.startsWith('123')) {
        throw WeakPasswordException();
      }
      return Pessoa(CodPessoa: Email.hashCode, Email: Email);
    } catch (e) {
      if (Senha.startsWith('123')) {
        throw 'Erro ao logar.Tente novamente';
      }
      throw 'Não foi possível acessar a conta.';
    }
  }

  @override
  Future<Pessoa> signUp({
    String? Nome,
    required String Email,
    required String Senha,
  }) async {
    try {
      await Future.delayed(Duration(seconds: 2));
      if (Senha.startsWith('123')) {
        throw WeakPasswordException();
      }
      return Pessoa(CodPessoa: Email.hashCode, Nome: Nome, Email: Email);
    } catch (e) {
      if (Senha.startsWith('123')) {
        throw 'Senha fraca. Use uma mais segura.';
      }
      throw 'Não foi possível criar a conta.';
    }
  }
  
  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}

@override
Future<void> signOut() async{
  
}

class WeakPasswordException {
  WeakPasswordException([
    String message =
        'A senha é muito fraca. Por favor, use uma senha mais segura.',
  ]);
}
