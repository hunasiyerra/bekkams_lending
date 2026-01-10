import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String? error;
  final Color color;
  final double? fontSize;
  final FontWeight? fontWeight;
  const ErrorText({
    super.key,
    this.error,
    required this.color,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    if (error == null || error!.isEmpty) {
      return const SizedBox.shrink();
    }

    if (error != null && error == "Loading") {
      return CircularProgressIndicator(strokeWidth: 2, color: Colors.white);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        error!,
        style: TextStyle(
          color: color,
          fontSize: fontSize ?? 13,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
      ),
    );
  }
}
