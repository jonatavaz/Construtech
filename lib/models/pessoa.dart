import 'package:construtech/models/usuario.dart';

class Pessoa extends Usuario {
  final int? CodPessoa;
  final String? Nome;
  final String? CPF;
  final String? Nascimento;

  Pessoa({
    int? CodUsuario, 
    required String Email,
    String? Senha,
    bool? Administrador,
    bool? Ativo,
    this.CodPessoa,
    this.Nome,
    this.CPF,
    this.Nascimento,
  }) : super(
          CodUsuario: CodUsuario, 
          Email: Email,
          Senha: Senha,
          Administrador: Administrador,
          Ativo: Ativo,
        );
  factory Pessoa.fromJson(Map<String, dynamic> json) {
    
  final usuarioData = json['usuario'] as Map<String, dynamic>? ?? {};
  
  final contatoData = json['contato'] as Map<String, dynamic>? ?? {};

  return Pessoa(
    CodUsuario: usuarioData['codUsuario'] as int?,
    Senha: usuarioData['senha'] as String?,
    Administrador: usuarioData['administrador'] as bool?,
    Ativo: usuarioData['ativo'] as bool?,
    
    Email: contatoData['email'] as String? ?? 'sem.email@construtech.com', 

    CodPessoa: json['codPessoa'] as int?,
    Nome: json['nome'] as String?,
    CPF: json['cpf'] as String?,
    Nascimento: json['nascimento'] as String?,
  );
  }
}