import 'package:flutter/material.dart';

class MyCustomColumn extends StatelessWidget {
  final String text;
  final IconData? iconData;
  const MyCustomColumn({super.key, required this.text, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(children: [Icon(iconData), Text(text)]);
  }
}
