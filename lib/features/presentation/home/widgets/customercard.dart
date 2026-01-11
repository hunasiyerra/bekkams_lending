import 'package:flutter/material.dart';

class CustomerCardWidget extends StatelessWidget {
  final String customerName;
  final String customerEmail;
  final String customerPhNo;

  const CustomerCardWidget({
    super.key,
    required this.customerName,
    required this.customerEmail,
    required this.customerPhNo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: Colors.blue.shade100,
        child: Text(
          customerName[0],
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      title: Text(
        customerName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customerEmail),
          const SizedBox(height: 2),
          Text(customerPhNo),
        ],
      ),
      trailing: IconButton(
        icon: const Icon(Icons.call, color: Colors.blue),
        onPressed: () {
          // TODO: call functionality
        },
      ),
    );
  }
}
