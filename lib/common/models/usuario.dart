import 'dart:ffi';

import 'package:construtech/common/models/contato.dart';

class Usuario extends Contato{
  final int? CodUsuaio;
  final int? CodPessoa;
  final String? Senha;
  final bool? Administrador;
  final bool? Ativo;

  Usuario({
    String? Telefone1,
    String? Telefone2,
    required String Email,
    this.CodUsuaio,
    this.CodPessoa,
    this.Senha,
    this.Administrador,
    this.Ativo,
  }): super(Telefone1: Telefone1, Telefone2: Telefone2, Email: Email);
}