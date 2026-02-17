import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noviindus_test/features/auth/domain/use_cases/login_use_case.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;

  AuthProvider(this.loginUseCase);

  final TextEditingController phoneController = TextEditingController();

  bool isLoading = false;
  String? error;
  String? token;

  String? accessToken;

  bool get isLoggedIn => accessToken != null;

  Future<void> login() async {
    final phone = phoneController.text.trim();
    if (phone.isEmpty || phone.length != 10) {
      error = "Enter valid 10 digit mobile number";
      notifyListeners();
      return;
    }

    try {
      isLoading = true;
      error = null;
      notifyListeners();

      final result = await loginUseCase(phone: phone, countryCode: "+91");
      token = result.access;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("access_token", token!);
    } catch (e) {
      error = "Login failed";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString("access_token");
    notifyListeners();
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
    accessToken = null;
    notifyListeners();
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
