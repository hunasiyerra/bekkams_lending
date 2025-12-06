import 'package:bekkams_lending/features/auth/data/firebaserepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class Authenticationprovider extends ChangeNotifier {
  final Firebaserepository firebaserepository;

  Authenticationprovider({required this.firebaserepository});

  final RegExp _pattern = RegExp(r"^[\w-\.]+@gmail.com");
  final RegExp _passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).+$',
  );

  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final confirmPasword = TextEditingController();

  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  bool _obscureText = true;
  bool _obscurePasswordText = true;
  bool _obscureTextlogin = true;
  User? _user;
  bool _loading = false;
  //String? _errorState = "";

  String? get emaillError => _emailError;
  String? get passwordError => _passwordError;
  bool? get obscureText => _obscureText;
  bool? get obscureTextlogin => _obscureTextlogin;
  bool? get obscurePasswordText => _obscurePasswordText;
  User? get userData => _user;
  bool? get loadingstate => _loading;
  String? get confirmPasswordError => _confirmPasswordError;
  //String? get errorstate => _errorState;

  Future<User?> signUpWithEmailAndPassword() async {
    String emailPassed = email.text.trim();
    String passwordPassed = password.text.trim();
    _emailError = validateEmail(emailPassed);
    if (_emailError == null || _passwordError == null) {
      _loading = true;
      notifyListeners();
      final result = await firebaserepository.signUp(
        emailPassed,
        passwordPassed,
      );
      final User? authuser = result.fold<User?>(
        (user) {
          _user = user;
          _loading = false;
          return _user;
        },
        (failure) {
          if (failure.code == "email-already-in-use") {
            _emailError = failure.message;
          }
          // else {
          //   _errorState = failure.message;
          // }
          _loading = false;
          notifyListeners();
          return null;
        },
      );
      return authuser;
    }
    notifyListeners();
    return null;
  }

  //used to clear error message of email and password.
  void clearEmailError() {
    _emailError = null;
    notifyListeners();
  }

  void clearPasswordError() {
    _passwordError = null;
    notifyListeners();
  }

  void checkPasswordError() {
    _passwordError = validatePassword(password.text.trim());
    notifyListeners();
  }

  // used to validate the Email and password
  String? validateEmail([String? email]) {
    if (email == null || email.isEmpty) {
      return "Please enter Email ID";
    } else if (!_pattern.hasMatch(email)) {
      return "Enter valid email ends with @gamail.com";
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return "Please enter password";
    } else if (password.length <= 7) {
      return "Password must contains 8 letters ";
    }
    if (!_passwordRegex.hasMatch(password)) {
      return "Include uppercase, lowercase, number & special character";
    }
    return null;
  }

  // Password show and hide
  void showPassword() {
    if (_obscureText == true) {
      _obscureText = false;
    } else {
      _obscureText = true;
    }

    notifyListeners();
  }

  void showLoginPassword() {
    if (_obscureTextlogin == true) {
      _obscureTextlogin = false;
    } else {
      _obscureTextlogin = true;
    }
    notifyListeners();
  }

  void showConfirmPassword() {
    if (_obscurePasswordText == true) {
      _obscurePasswordText = false;
    } else {
      _obscurePasswordText = true;
    }
    notifyListeners();
  }

  void checkConfirmPassword(String checkpassword) {
    if (password.text.trim() != checkpassword.trim() ||
        confirmPasword.text.trim() != checkpassword.trim()) {
      _confirmPasswordError = "Please enter the same password";
    } else if (password.text.trim() == checkpassword.trim()) {
      _confirmPasswordError = null;
    }
    notifyListeners();
  }
}
