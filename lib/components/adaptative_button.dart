import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;

  AdaptativeButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary),
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
