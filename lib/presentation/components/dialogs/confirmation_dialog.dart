import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = 'Confirmar',
    this.cancelText = 'Cancelar',
  });

  final String title;
  final String content;
  final String confirmText;
  final String cancelText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(cancelText.toUpperCase()),
        ),

        TextButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            confirmText.toUpperCase(),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
