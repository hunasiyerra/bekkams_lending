import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final String? errortext;
  final TextEditingController textEditingController;
  final void Function()? ontap;
  final Widget? suffixIcon;
  final Widget? perfixIcon;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final Color? errorColor;
  final Color? errorTextColor;
  final TextInputType? keyboardType;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
    required this.errortext,
    this.ontap,
    this.suffixIcon,
    this.obscureText,
    this.onChanged,
    this.errorColor,
    this.errorTextColor,
    this.perfixIcon,
    this.keyboardType,
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
          keyboardType: keyboardType,
          style: TextStyle(color: Colors.white),
          controller: textEditingController,
          onTap: ontap,
          onChanged: onChanged,
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
            prefixIcon: perfixIcon,
            prefixIconColor: Colors.green,
          ),
        ),
      ],
    );
  }
}
