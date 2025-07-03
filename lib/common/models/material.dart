class Materials {
  final int codMaterial;
  final String nome;
  final String? descricao;
  final int codObra;
  final String nomeObra;
  final int unidade;

  Materials({
    required this.codMaterial,
    required this.nome,
    required this.descricao,
    required this.codObra,
    required this.nomeObra,
    required this.unidade,
  });

  factory Materials.fromJson(Map<String, dynamic> json) {
    return Materials(
      codMaterial: json['codMaterial'] as int,
      nome: json['nome'] as String,
      descricao: json['descricao'] as String?,
      codObra: json['codObra'] as int,
      nomeObra: json['nomeObra'] as String, 
      unidade: json['unidade'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codMaterial': codMaterial,
      'nome': nome,
      'descricao': descricao,
      'codObra': codObra,
      'nomeObra': nomeObra,
      'unidade': unidade,
    };
  }
}