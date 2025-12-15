import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String? error;

  const ErrorText({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    if (error == null || error!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        error!,
        style: const TextStyle(color: Colors.red, fontSize: 13),
      ),
    );
  }
}
