import 'package:bekkams_lending/features/auth/presentation/widgets/filledbutton.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';

class AuthSignUpPage extends StatefulWidget {
  const AuthSignUpPage({super.key});

  @override
  State<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends State<AuthSignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Sign Up Screen",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            SizedBox(height: 20),
            MyTextField(
              fieldName: 'User Name',
              hintText: 'Enter User name',
              textEditingController: TextEditingController(),
            ),
            SizedBox(height: 20),
            MyTextField(
              fieldName: 'Password',
              hintText: 'Enter Password',
              textEditingController: TextEditingController(),
            ),
            SizedBox(height: 20),
            CustomFilledButton(onPressed: () {}, buttonName: "Login"),
          ],
        ),
      ),
    );
  }
}
