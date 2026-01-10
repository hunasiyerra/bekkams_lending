import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final Widget text;
  final void Function()? ontap;
  const MyTextButton({super.key, required this.text, this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: ontap, child: text);
  }
}
