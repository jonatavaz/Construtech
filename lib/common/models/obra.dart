class Obra {
  final int codObra;
  final int codCliente;
  final String? nomeCliente;
  final String
  nomeObra;
  final String endereco;
  final String tipo;
  final String prazoExecucao;
  final String estagioAtual;
  final String? detalhes; 

  Obra({
    required this.codObra,
    required this.codCliente,
    this.nomeCliente,
    required this.nomeObra,
    required this.endereco,
    required this.tipo,
    required this.prazoExecucao,
    required this.estagioAtual,
    this.detalhes,
  });

  factory Obra.fromJson(Map<String, dynamic> json) {
    return Obra(
      codObra: json['codObra'] as int,
      codCliente: json['codCliente'] as int,
      nomeCliente: json['nomeCliente'] as String?,
      nomeObra:
          json['nomeObra'] as String, 
      endereco: json['endereco'] as String,
      tipo: json['tipo'] as String,
      prazoExecucao: json['prazoExecucao'] as String,
      estagioAtual: json['estagioAtual'] as String,
      detalhes: json['detalhes'] as String?, 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codObra': codObra,
      'codCliente': codCliente,
      'nomeCliente': nomeCliente,
      'nomeObra': nomeObra,
      'endereco': endereco,
      'tipo': tipo,
      'prazoExecucao': prazoExecucao,
      'estagioAtual': estagioAtual,
      'detalhes': detalhes,
    };
  }
}
