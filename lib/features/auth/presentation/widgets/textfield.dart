import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String? errortext;
  final TextEditingController textEditingController;
  final void Function()? onChanged;
  final Widget? suffixIcon;
  final bool? obscureText;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.errortext,
    this.onChanged,
    this.suffixIcon,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          obscureText: obscureText ?? true,
          cursorColor: Colors.white,
          cursorWidth: 1.25,
          style: TextStyle(color: Colors.white),
          controller: textEditingController,
          onTap: onChanged,
          decoration: InputDecoration(
            filled: true,
            hintText: hintText,
            errorText: errortext,
            errorMaxLines: 2,
            hintStyle: TextStyle(color: Colors.white),
            fillColor: const Color.fromARGB(255, 21, 20, 20),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: const Color.fromARGB(255, 21, 20, 20),
              ),
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),

            suffixIcon: suffixIcon,
            suffixIconColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
