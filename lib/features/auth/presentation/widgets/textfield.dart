import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String fieldName;
  final String hintText;
  final TextEditingController textEditingController;
  const MyTextField({
    super.key,
    required this.fieldName,
    required this.hintText,
    required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            fieldName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: textEditingController,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(10),
                right: Radius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
