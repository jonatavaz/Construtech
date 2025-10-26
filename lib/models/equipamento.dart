class Equipamento {
  final int codObraEquipamento;
  final int codObra; 
  final int codEquipamento;
  final String? dataAlocacao; 
  final String? dataRetorno;
  final String nomeObra;
  final String nomeEquipamento; 
  final double custoHora; 
  final String disponibilidadeObra; 
  final bool manutencao; 


  Equipamento({
    required this.codObraEquipamento,
    required this.codObra,
    required this.codEquipamento,
    this.dataAlocacao,
    this.dataRetorno,
    required this.nomeObra,
    required this.nomeEquipamento,
    required this.custoHora,
    required this.disponibilidadeObra,
    required this.manutencao,
  });

  factory Equipamento.fromJson(Map<String, dynamic> json) {
    return Equipamento(
      codObraEquipamento: json['codObraEquipamento'] as int,
      codObra: json['codObra'] as int,
      codEquipamento: json['codEquipamento'] as int,
      dataAlocacao: json['dataAlocacao'] as String?,
      dataRetorno: json['dataRetorno'] as String?,
      nomeObra: json['nomeObra'] as String,
      nomeEquipamento: json['nomeEquipamento'] as String,
      custoHora: (json['custoHora'] is int)
          ? (json['custoHora'] as int).toDouble()
          : json['custoHora'] as double,
      disponibilidadeObra: json['disponibilidadeObra'] as String,
      manutencao: json['manutencao'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codObraEquipamento': codObraEquipamento,
      'codObra': codObra,
      'codEquipamento': codEquipamento,
      'dataAlocacao': dataAlocacao,
      'dataRetorno': dataRetorno,
      'nomeObra': nomeObra,
      'nomeEquipamento': nomeEquipamento,
      'custoHora': custoHora,
      'disponibilidadeObra': disponibilidadeObra,
      'manutencao': manutencao,
    };
  }
}