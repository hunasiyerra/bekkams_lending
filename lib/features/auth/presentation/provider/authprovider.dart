import 'package:bekkams_lending/features/auth/data/domain/entities/userdata.dart';
import 'package:bekkams_lending/features/auth/data/domain/models/userdatamodel.dart';
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

  User? _user;
  final email = TextEditingController();
  final password = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final phoneNumber = TextEditingController();
  final confirmPasword = TextEditingController();

  Userdata? _userProfile;
  Userdata? get userProfile => _userProfile;

  //Error values
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;
  String? _firstNameError;
  String? _lastNameError;
  String? _phoneNumberError;

  // state and obscure values
  bool _obscureText = true;
  bool _obscurePasswordText = true;
  //bool _obscureTextlogin = true;
  bool _loading = false;
  bool _errorState = false;

  // getter values
  String? get emaillError => _emailError;
  String? get passwordError => _passwordError;
  bool? get obscureText => _obscureText;
  // bool? get obscureTextlogin => _obscureTextlogin;
  bool? get obscurePasswordText => _obscurePasswordText;
  User? get userData => _user;
  bool? get loadingstate => _loading;
  String? get confirmPasswordError => _confirmPasswordError;
  String? get firstNameError => _firstNameError;
  String? get lastNameError => _lastNameError;
  String? get phoneNumberErrow => _phoneNumberError;
  bool? get errorstate => _errorState;

  Future<User?> signUpWithEmailAndPassword() async {
    String emailPassed = email.text.trim();
    String passwordPassed = password.text.trim();
    _emailError = validateEmail(emailPassed);
    _passwordError = validatePassword(passwordPassed);
    String? errorFiled = validatefielddata();
    if (_emailError == null && _passwordError == null && errorFiled == null) {
      _loading = true;
      notifyListeners();
      final result = await firebaserepository.signUp(
        emailPassed,
        passwordPassed,
      );
      final User? authuser = result.fold<User?>(
        (user) {
          _user = user;
          return _user;
        },
        (failure) {
          if (failure.code == "email-already-in-use") {
            _emailError = failure.message;
          }
          _loading = false;
          notifyListeners();
          return null;
        },
      );
      if (authuser != null) {
        final result = await firebaserepository.saveUserdata(
          Userdata(
            uId: _user!.uid.trim(),
            firstName: firstName.text.trim(),
            lastName: lastName.text.trim(),
            email: email.text.trim(),
            phoneNumber: int.parse(phoneNumber.text.trim()),
            role: "admin",
            createdAt: DateTime.now(),
          ),
        );
        final data = result.fold((value) => value, (failure) => null);
        if (data != null) {
          _loading = false;
          clearAuthFields();
          notifyListeners();
          return authuser;
        } else {
          _errorState = true;
          _loading = false;
          notifyListeners();
          _user!.delete();
          return null;
        }
      }
    }
    notifyListeners();
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    _loading = true;
    notifyListeners();
    _emailError = validateEmail(email);
    _passwordError = validatePassword(password);
    if (_emailError == null && _passwordError == null) {
      final result = await firebaserepository.signIn(email, password);
      final session = await result.fold(
        (user) async {
          _user = user;
          await fetchProfileData(_user!.uid);
          _loading = false;
          return _user;
        },
        (failure) {
          if (failure.code == "invalid-credential") {
            _errorState = true;
            return null;
          }
        },
      );
      notifyListeners();
      return session;
    }
    notifyListeners();
    return null;
  }

  fetchProfileData(String uid) async {
    final userData = await firebaserepository.fetchUserData(uid);
    userData.fold((data) {
      _userProfile = data;
      notifyListeners();
    }, (failure) => _errorState = true);
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

  void clearFirstNameError() {
    _firstNameError = null;
    notifyListeners();
  }

  void clearLastNameError() {
    _lastNameError = null;
    notifyListeners();
  }

  void clearPhoneNumError() {
    _phoneNumberError = null;
    notifyListeners();
  }

  void checkPasswordError() {
    _passwordError = validatePassword(password.text.trim());
    notifyListeners();
  }

  // used to validate the Email, password and field values.
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

  String? validatefielddata() {
    if (firstName.text.trim().isEmpty) {
      _firstNameError = "Please enter firstName";
    }
    if (lastName.text.trim().isEmpty) {
      _lastNameError = "Please enter lastName";
    }
    if (phoneNumber.text.trim().isEmpty) {
      _phoneNumberError = "Please enter PhoneNumber";
      return _phoneNumberError;
    } else if (phoneNumber.text.trim().length != 10) {
      _phoneNumberError = "Phone Number should be 10 digits";
    }
    if (_firstNameError != null ||
        _lastNameError != null ||
        _phoneNumberError != null) {
      return "errorfields";
    } else {
      return null;
    }
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

  // void showLoginPassword() {
  //   if (_obscureTextlogin == true) {
  //     _obscureTextlogin = false;
  //   } else {
  //     _obscureTextlogin = true;
  //   }
  //   notifyListeners();
  // }

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

  void clearAuthFields() {
    email.clear();
    password.clear();
    firstName.clear();
    lastName.clear();
    confirmPasword.clear();
  }
}
