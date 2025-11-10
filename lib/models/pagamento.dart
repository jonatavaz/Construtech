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
  try {
    return Pagamento(
      codPagamento: json['codPagamento'] as int? ?? 0,
      codFormaPagamento: json['codFormaPagamento'] as int? ?? 0,
      codObra: json['codObra'] as int? ?? 0,
      
      valorPago: (json['valorPago'] is num)
          ? (json['valorPago'] as num).toDouble()
          : 0.0,
      
      dataHoraPagamento: json['dataHora_Pagamento'] as String?, 

      nomeObra: json['nomeObra'] as String? ?? 'Obra não informada',
      formaPagamento: json['formaPagamento'] as String? ?? 'Forma não informada',
      
      obra: null, 
    );
  } catch (e) {
      return Pagamento(
        codPagamento: -1,
        nomeObra: 'Erro de parsing',
      );
  }
}

  Map<String, dynamic> toJson() {
    return {
      'codPagamento': codPagamento,
      'codFormaPagamento': codFormaPagamento,
      'codObra': codObra,
      'valorPago': valorPago,
      'dataHoraPagamento': dataHoraPagamento,
      'nome': nomeObra,
      'formaPagamento': formaPagamento,
      'obra': obra,
    };
  }
}
