import 'package:construtech/common/constants/app_text_style.dart';
import 'package:construtech/common/widgets/primay_button.dart';
import 'package:flutter/material.dart';

class SignInError {
   final String message;
   final String? code;

   SignInError({required this.message, this.code});
}


Future<dynamic> customModalBottomSheet(
  BuildContext context,
  SignInError errorState,
) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    ),
    builder: (BuildContext modalContext) { 
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Icon(Icons.error, color: Colors.red, size: 40),
            const SizedBox(height: 10),
            Text(
             
              errorState.message,
              textAlign: TextAlign.center,
              style: AppTextStyle.mediumText20.copyWith(color: Colors.red.shade800), 
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: PrimaryButton(
                text: 'Voltar',
                onPressed: () => Navigator.pop(modalContext), 
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      );
    },
  );
}
