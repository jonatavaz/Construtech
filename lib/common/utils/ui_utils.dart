import 'package:flutter/material.dart';

// Função para exibir alertas (SnackBar)
void showAlerts(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: Colors.blue.shade700, 
      duration: const Duration(seconds: 3), 
      behavior: SnackBarBehavior.floating, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), 
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20), 
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      elevation: 6,
    ),
  );
}

void showAlertDialogs(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
