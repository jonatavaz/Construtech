
import 'dart:developer';

class FormaPagamento {
  final int codFormaPagamento;
  final String nome;

  FormaPagamento({required this.codFormaPagamento, required this.nome});

  factory FormaPagamento.fromJson(Map<String, dynamic> json) {
    try {
      return FormaPagamento(
        codFormaPagamento: json['codFormaPagamento'] as int? ?? 0,
        nome: json['nome'] as String? ?? 'Forma inválida',
      );
    } catch (e) {
      log("Erro no FormaPagamento.fromJson: $e. JSON: $json");
      return FormaPagamento(codFormaPagamento: -1, nome: "Erro");
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormaPagamento &&
          runtimeType == other.runtimeType &&
          codFormaPagamento == other.codFormaPagamento;

  @override
  int get hashCode => codFormaPagamento.hashCode;
}