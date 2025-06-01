import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:flutter/material.dart';

class SignInError {
   final String message;
   final String? code; // Talvez um código de erro

   SignInError({required this.message, this.code});
}


Future<dynamic> customModalBottomSheet(
  BuildContext context,
  // --- ALTERAÇÃO AQUI: Adicionar o parâmetro para o objeto de erro ---
  SignInError errorState, // Adicione o parâmetro do tipo SignUpErrorState
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Adicionado para melhor controle da altura se o conteúdo variar
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)), // Borda arredondada
    ),
    builder: (BuildContext modalContext) { // Renomeado o context interno para modalContext para evitar ambiguidade
      return Padding( // Adicionei um Padding geral ao modal
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Faz a coluna ocupar o mínimo de altura
          children: <Widget>[
            const Icon(Icons.error, color: Colors.red, size: 40), // Ícone de erro
            const SizedBox(height: 10),
            Text(
              // --- ALTERAÇÃO AQUI: Usar a mensagem do objeto de erro ---
              errorState.message, // Acessa a propriedade 'message' do seu objeto de erro
              textAlign: TextAlign.center,
              style: AppTextStyle.mediumText20.copyWith(color: Colors.red.shade800), // Cor para o erro
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: PrimaryButton(
                text: 'Voltar',
                onPressed: () => Navigator.pop(modalContext), // Usa modalContext aqui
              ),
            ),
            const SizedBox(height: 10), // Pequeno espaço no final
          ],
        ),
      );
    },
  );
}