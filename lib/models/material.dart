import 'dart:developer';

// 1. CONVENÇÃO: O nome da classe deve ser singular (Material)
//    para representar um único item.
class Material { // ANTIGO: Materials
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

  // 2. CORREÇÃO: Aplicando o factory seguro
  factory Material.fromJson(Map<String, dynamic> json) { // ANTIGO: Materials.fromJson
    try {
      return Material( // ANTIGO: Materials
        // Use 'as int? ?? 0' para segurança contra nulos
        codMaterial: json['codMaterial'] as int? ?? 0,
        
        // Use 'as String? ?? '...' para segurança
        nome: json['nome'] as String? ?? 'Nome indisponível',
        
        // Este já estava seguro
        descricao: json['descricao'] as String?,
        
        codObra: json['codObra'] as int? ?? 0,
        
        // ATENÇÃO: Verifique se a chave é 'nomeObra' ou 'nome'
        // (Baseado no seu modelo Obra, a API C# pode enviar 'nome' 
        // e o DTO C# 'nomeObra', então o JSON 'nomeObra' pode estar correto)
        nomeObra: json['nomeObra'] as String? ?? 'Obra indisponível', 
        
        unidade: json['unidade'] as int? ?? 0,
      );
    } catch (e) {
      log("Erro ao processar Material.fromJson: $e. JSON: $json");
      // Retorna um objeto de erro padrão
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