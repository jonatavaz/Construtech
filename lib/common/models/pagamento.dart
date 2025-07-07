
class Pagamento {
  final int? codPagamento;
  final int? codFormaPagamento;
  final int? codObra;
  final double? valorPago;
  final String? dataHoraPagamento;
  final String? nomeObra;
  final String? formaPagamento;
  final dynamic obra;

  Pagamento({
    this.codPagamento,
    this.codFormaPagamento,
    this.codObra,
    this.valorPago,
    this.dataHoraPagamento,
    this.nomeObra,
    this.formaPagamento,
    this.obra,
  });

  factory Pagamento.fromJson(Map<String, dynamic> json) {
    return Pagamento(
      codPagamento: json['codPagamento'] as int?,
      codFormaPagamento: json['codFormaPagamento'] as int?,
      codObra: json['codObra'] as int?,
      valorPago: (json['ValorPago'] is num)
          ? (json['ValorPago'] as num).toDouble()
          : null,
      dataHoraPagamento: json['DataHoraPagamento'] as String?,
      nomeObra: json['Nome'] as String?,
      formaPagamento: json['formaPagamento'] as String?,
      obra: json['obra'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codPagamento': codPagamento,
      'codFormaPagamento': codFormaPagamento,
      'codObra': codObra,
      'valorPago': valorPago,
      'dataHoraPagamento': dataHoraPagamento,
      'Nome': nomeObra,
      'formaPagamento': formaPagamento,
      'obra': obra,
    };
  }
}