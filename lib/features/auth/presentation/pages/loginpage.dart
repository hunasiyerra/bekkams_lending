import 'package:bekkams_lending/features/auth/presentation/pages/signuppage.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/filledbutton.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/textbutton.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';

class AuthLoginPage extends StatefulWidget {
  const AuthLoginPage({super.key});

  @override
  State<AuthLoginPage> createState() => _AuthLoginPageState();
}

class _AuthLoginPageState extends State<AuthLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login Screen",
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
                hintText: 'Enter Password0',
                textEditingController: TextEditingController(),
              ),
              SizedBox(height: 20),
              CustomFilledButton(onPressed: () {}, buttonName: "Login"),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have a account Please",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 10),
                  MyTextButton(
                    text: Text(
                      "Click here",
                      style: TextStyle(color: Colors.blue),
                    ),
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthSignUpPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
