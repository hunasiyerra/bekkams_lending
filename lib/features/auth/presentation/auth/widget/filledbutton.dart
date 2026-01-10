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
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          const Color.fromARGB(255, 29, 28, 28),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 95),
        child: Text(buttonName, style: TextStyle(fontSize: 15)),
      ),
    );
  }
}
