
import 'dart:developer';

class Fornecedor {
  final int codFornecedor;
  final String? historico;
  final String avaliacao;
  final String? dataHoraCadastro; 
  final String nome;
  final String? cpf;
  final String? nascimento;
  final String? telefone;
  final String? email;
  final String? senha;

  Fornecedor({
    required this.codFornecedor,
    this.historico,
    required this.avaliacao,
    this.dataHoraCadastro, 
    required this.nome,
    this.cpf,
    this.nascimento,
    this.telefone,
    this.email,
    this.senha,
  });

  factory Fornecedor.fromJson(Map<String, dynamic> json) {
    try {
      return Fornecedor(
        codFornecedor: json['codFornecedor'] as int? ?? 0,
        historico: json['historico'] as String?,
        avaliacao: json['avaliacao'] as String? ?? 'N/A',
        
        nome: json['nome'] as String? ?? 'Nome indisponível',
        cpf: json['cpf'] as String?,
        nascimento: json['nascimento'] as String?,
        senha: json['senha'] as String?,
        email: json['email'] as String?,
        telefone: json['telefone'] as String?,

      );
    } catch (e) {
      log("Erro ao processar Fornecedor.fromJson: $e. JSON: $json");
      return Fornecedor(
        codFornecedor: -1,
        avaliacao: 'Erro',
        nome: 'Erro de parsing',
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'codFornecedor': codFornecedor,
      'historico': historico,
      'avaliacao': avaliacao,
      'nome': nome,
      'cpf': cpf,
      'nascimento': nascimento,
      'telefone': telefone,
      'email': email,
      'senha': senha,
    };
  }
}