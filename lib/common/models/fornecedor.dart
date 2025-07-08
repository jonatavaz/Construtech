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
    return Fornecedor(
      codFornecedor: json['codFornecedor'] as int,
      historico: json['historico'] as String?,
      avaliacao: json['avaliacao'] as String,
      dataHoraCadastro: json['dataHora_Cadastro'] as String?,
      nome: json['nome'] as String,
      cpf: json['cpf'] as String?,
      nascimento: json['nascimento'] as String?,
      telefone: json['telefone'] as String?,
      email: json['email'] as String?,
      senha: json['senha'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codFornecedor': codFornecedor,
      'historico': historico,
      'avaliacao': avaliacao,
      'dataHora_Cadastro': dataHoraCadastro,
      'nome': nome,
      'cpf': cpf,
      'nascimento': nascimento,
      'telefone': telefone,
      'email': email,
      'senha': senha,
    };
  }
}
