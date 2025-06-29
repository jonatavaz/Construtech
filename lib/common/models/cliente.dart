// lib/common/models/cliente.dart

class Cliente {
  final int codCliente;
  final String nome;

  Cliente({required this.codCliente, required this.nome});

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      codCliente: json['codCliente'] as int,
      nome: json['nome'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'codCliente': codCliente, 'nome': nome};
  }
}
