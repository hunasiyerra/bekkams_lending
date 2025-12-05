import 'package:bekkams_lending/features/auth/presentation/pages/homepage.dart';
import 'package:bekkams_lending/features/auth/presentation/provider/authprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/filledbutton.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthSignUpPage extends StatefulWidget {
  const AuthSignUpPage({super.key});

  @override
  State<AuthSignUpPage> createState() => _AuthSignUpPageState();
}

class _AuthSignUpPageState extends State<AuthSignUpPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Authenticationprovider>(
      builder: (context, authenticationprovider, child) {
        return authenticationprovider.loadingstate == true
            ? Center(child: CircularProgressIndicator(color: Colors.white))
            : Scaffold(
              backgroundColor: Colors.black,
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    MyTextField(
                      obscureText: false,
                      errortext: authenticationprovider.emaillError,
                      hintText: 'Email',
                      textEditingController: email,
                      onChanged: () {
                        authenticationprovider.clearEmailError();
                      },
                    ),
                    SizedBox(height: 20),
                    MyTextField(
                      obscureText: authenticationprovider.obscureText,
                      errortext: authenticationprovider.passwordError,
                      hintText: 'Password',
                      textEditingController: password,
                      onChanged: () {
                        authenticationprovider.clearPasswordError();
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          authenticationprovider.showPassword();
                        },
                        icon:
                            authenticationprovider.obscureText == true
                                ? Icon(Icons.remove_red_eye)
                                : Icon(Icons.remove_red_eye_outlined),
                      ),
                    ),
                    SizedBox(height: 20),
                    CustomFilledButton(
                      onPressed: () async {
                        final user = await authenticationprovider
                            .signUpWithEmailAndPassword(
                              email.text.trim(),
                              password.text.trim(),
                            );
                        if (!mounted) return;
                        print(user);
                        if (user != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ),
                          );
                        }
                        // else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //         authenticationprovider.errorstate!,
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //       backgroundColor: Colors.grey[800],
                        //     ),
                        //   );
                        // }
                      },
                      buttonName: "Signup",
                    ),
                  ],
                ),
              ),
            );
      },
    );
  }
}
