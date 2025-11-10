import 'dart:developer';

class Material { 
  final int codMaterial;
  final String nome;
  final String? descricao;
  final int codObra;
  final String nomeObra;
  final int unidade;

  Material({ // ANTIGO: Materials
    required this.codMaterial,
    required this.nome,
    required this.descricao,
    required this.codObra,
    required this.nomeObra,
    required this.unidade,
  });

  factory Material.fromJson(Map<String, dynamic> json) {
    try {
      return Material(
        codMaterial: json['codMaterial'] as int? ?? 0,
        
        nome: json['nome'] as String? ?? 'Nome indisponível',
        
        descricao: json['descricao'] as String?,
        
        codObra: json['codObra'] as int? ?? 0,
        nomeObra: json['nomeObra'] as String? ?? 'Obra indisponível', 
        
        unidade: json['unidade'] as int? ?? 0,
      );
    } catch (e) {
      log("Erro ao processar Material.fromJson: $e. JSON: $json");
      return Material(
        codMaterial: -1,
        nome: 'Erro ao carregar',
        descricao: '',
        codObra: -1,
        nomeObra: '',
        unidade: 0,
      );
    }
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