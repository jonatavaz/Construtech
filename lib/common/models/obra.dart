// lib/common/models/obra.dart

class Obra {
  final int codObra;
  final int codCliente;
  final String? nomeCliente; // Pode ser null, como no seu retorno
  final String
  nomeObra; // Renomeado de 'nome' para 'nomeObra' para evitar conflito
  final String endereco;
  final String tipo; // Tipo da obra (Casa/Prédio)
  final String prazoExecucao;
  final String estagioAtual;
  final String? detalhes; // Pode ser null

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
      nomeCliente: json['nomeCliente'] as String?, // É anulável na API
      nomeObra:
          json['nomeObra'] as String, // Corresponde à coluna Nome AS NomeObra
      endereco: json['endereco'] as String,
      tipo: json['tipo'] as String,
      prazoExecucao: json['prazoExecucao'] as String,
      estagioAtual: json['estagioAtual'] as String,
      detalhes: json['detalhes'] as String?, // É anulável na API
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
