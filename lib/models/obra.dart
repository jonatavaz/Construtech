
import 'dart:developer';

class Obra {
  final int codObra;
  final int codCliente;
  final String? nomeCliente;
  final String nomeObra;
  final String endereco;
  final String tipo;
  final String prazoExecucao;
  final String estagioAtual;
  final String? detalhes;

  Obra({
    required this.codObra,
    required this.codCliente,
    this.nomeCliente,
    required this.nomeObra,
    required this.endereco,
    required this.tipo,
    required this.prazoExecucao,
    required this.estagioAtual,
    this.detalhes,
  });

  factory Obra.fromJson(Map<String, dynamic> json) {
    try {
      return Obra(
        codObra: json['codObra'] as int? ?? 0,
        codCliente: json['codCliente'] as int? ?? 0,
        
        nomeCliente: json['nomeCliente'] as String?,
        
        nomeObra: json['nome'] as String? ?? 'Nome indisponível',
        
        endereco: json['endereco'] as String? ?? 'Endereço indisponível',
        tipo: json['tipo'] as String? ?? 'Tipo indisponível',
        prazoExecucao: json['prazoExecucao'] as String? ?? 'Prazo indisponível',
        estagioAtual: json['estagioAtual'] as String? ?? 'Estágio indisponível',
        detalhes: json['detalhes'] as String?,
      );
    } catch (e) {
      log("Erro ao processar Obra.fromJson: $e. JSON: $json");
      return Obra(
        codObra: -1,
        codCliente: -1,
        nomeCliente: "Erro",
        nomeObra: "Erro ao carregar obra",
        endereco: "",
        tipo: "",
        prazoExecucao: "",
        estagioAtual: "",
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'codObra': codObra,
      'codCliente': codCliente,
      'nomeCliente': nomeCliente,
      
      'nome': nomeObra, 
      
      'endereco': endereco,
      'tipo': tipo,
      'prazoExecucao': prazoExecucao,
      'estagioAtual': estagioAtual,
      'detalhes': detalhes,
    };
  }
}