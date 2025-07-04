import 'package:decimal/decimal.dart';

class Pagamento {
  final String nomeObra;
  final String dataHoraPagamento; 
  final double valorPago;

  Pagamento({
    required this.nomeObra,
    required this.dataHoraPagamento,
    required this.valorPago,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) {
    return Pagamento(
      nomeObra: json['Nome'] as String,
      dataHoraPagamento: json['DataHoraPagamento'] as String,
      valorPago: (json['ValorPago'] is int)
          ? (json['ValorPago'] as Decimal).toDouble()
          : json['ValorPago'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Nome': nomeObra,
      'DataHoraPagamento': dataHoraPagamento,
      'ValorPago': valorPago,
    };
  }
}