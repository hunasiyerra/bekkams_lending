import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function() onPressed;
  final String buttonName;
  const CustomFilledButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
        child: Text(buttonName, style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
