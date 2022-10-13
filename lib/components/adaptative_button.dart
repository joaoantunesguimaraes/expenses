import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeButton extends StatelessWidget {
  final String? label;
  final Function()? onPressed;

  // Construtor
  const AdaptativeButton({
    this.label,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            color: Theme.of(context).textTheme.button?.color,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Text(label!),
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(
              label!,
              style: TextStyle(
                color: Theme.of(context).textTheme.button?.color,
              ),
            ),
          );
  }
}
