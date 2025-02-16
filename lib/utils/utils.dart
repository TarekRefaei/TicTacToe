import 'package:flutter/material.dart';

import '../resources/game_methods.dart';

void showGameDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              GameMethods().resetGame(context);
              Navigator.of(context).pop();
            },
            child: const Text('Play Again'),
          ),
        ],
      );
    },
  );
}
