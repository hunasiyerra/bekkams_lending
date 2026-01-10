import 'package:flutter/material.dart';

class FileUploadButton extends StatelessWidget {
  final void Function()? onPressed;
  //final Widget text;
  //final Icon? icon;
  final String buttonName;
  const FileUploadButton({
    super.key,
    this.onPressed,
    //required this.text,
    // this.icon,
    required this.buttonName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          buttonName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 20),
        FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(255, 29, 28, 28),
          onPressed: onPressed,
          label: Text(
            "Upload",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          icon: Icon(Icons.arrow_upward, color: Colors.white),
        ),
      ],
    );
  }
}
