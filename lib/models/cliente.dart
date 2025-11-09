
import 'dart:developer';

class Cliente {
  final int codCliente; 
  final String nome;

  Cliente({required this.codCliente, required this.nome});

  factory Cliente.fromJson(Map<String, dynamic> json) {
    try {
      final int id = json['codCliente'] as int? ?? 0;
      final String nomeCliente = json['nome'] as String? ?? 'Nome não encontrado';

      return Cliente(
        codCliente: id,
        nome: nomeCliente,
      );

    } catch (e) {
      log("Erro ao processar Cliente.fromJson: $e. JSON: $json");
      return Cliente(codCliente: -1, nome: "Erro de Parsing");
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Cliente &&
          runtimeType == other.runtimeType &&
          codCliente == other.codCliente;

  @override
  int get hashCode => codCliente.hashCode;
}