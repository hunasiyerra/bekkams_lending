import 'package:bekkams_lending/features/presentation/auth/widget/glasscard.dart';
import 'package:flutter/material.dart';

class MyDocumentTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? value;
  final VoidCallback onTap;
  const MyDocumentTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isVerified = value != null;
    return MyGlassCard(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value ?? subtitle,
                  style: TextStyle(
                    color:
                        isVerified && value!.length > 16
                            ? Colors.redAccent
                            : isVerified
                            ? Colors.greenAccent
                            : Colors.white60,
                    fontWeight:
                        isVerified ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isVerified && value!.length > 16
                ? Icons.upload
                : Icons.check_circle,
            color:
                isVerified && value!.length > 16
                    ? Colors.white54
                    : Colors.greenAccent,
          ),
          const SizedBox(width: 8),
          if (isVerified && value!.length > 16)
            GestureDetector(
              onTap: onTap,
              child: const Text(
                "Upload",
                style: TextStyle(color: Colors.white54),
              ),
            ),
        ],
      ),
    );
  }
}
