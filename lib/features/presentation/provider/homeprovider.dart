import 'package:bekkams_lending/features/data/auth/domain/entities/userdata.dart';
import 'package:bekkams_lending/features/data/auth/firebaserepository.dart';
import 'package:bekkams_lending/features/presentation/home/pages/customerspage.dart';
import 'package:bekkams_lending/features/presentation/home/pages/loanpage.dart';
import 'package:bekkams_lending/features/presentation/pages/Dashboardpage.dart';
import 'package:bekkams_lending/features/presentation/pages/myprofilepage.dart';
import 'package:flutter/material.dart';

class HomeProfileprovider extends ChangeNotifier {
  final Firebaserepository firebaserepository;
  HomeProfileprovider({required this.firebaserepository});

  int _currentIndex = 0;
  bool _errorProfileState = false;

  Userdata? _userProfile;

  Userdata? get userProfile => _userProfile;
  int get currentIndex => _currentIndex;
  bool get errorProfileState => _errorProfileState;

  final List<Widget> pages = const [
    MyDashboardPage(),
    MyLoanpage(),
    MyCustomersPage(),
    Myprofilepage(),
  ];

  changeNavigationIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> fetchProfileData(String uid) async {
    final userData = await firebaserepository.fetchUserData(uid);
    userData.fold(
      (data) {
        _userProfile = data;
        notifyListeners();
      },
      (failure) {
        _errorProfileState = true;
        notifyListeners();
      },
    );
  }

  Future appSignOut() async {
    await firebaserepository.signOut();
  }

  void clear() {
    _userProfile = null;
    notifyListeners();
  }
}
