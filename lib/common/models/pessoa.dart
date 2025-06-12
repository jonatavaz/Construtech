import 'dart:ffi';

import 'package:construtech/common/models/usuario.dart';

class Pessoa extends Usuario{
  final int? CodPessoa;
  final String? Nome;
  final String? CPF;
  final String? Nascimento; 

  Pessoa({
    int? CodUsuaio,
    required String Email,
    String? Senha,
    bool? Administrador,
    bool? Ativo,
    this.CodPessoa,
    this.Nome,
    this.CPF,
    this.Nascimento,
  }): super(CodUsuaio: CodUsuaio, Email: Email, Senha: Senha, Administrador: Administrador, Ativo: Ativo) ;
}