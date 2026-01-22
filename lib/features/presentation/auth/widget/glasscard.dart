import 'package:flutter/material.dart';

class MyGlassCard extends StatelessWidget {
  final Widget child;
  const MyGlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: child,
    );
    ;
  }
}
