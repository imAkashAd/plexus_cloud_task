import 'package:flutter/material.dart';
import 'package:plexus_task/core/services/api_service.dart';
import 'package:plexus_task/core/services/auth_service.dart';
import 'package:plexus_task/core/services/storage_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService;

  AuthController(this._authService);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoginLoading = false;
  bool get isLoginLoading => _isLoginLoading;

  bool _isSignupLoading = false;
  bool get isSignupLoading => _isSignupLoading;

  bool _isOtpLoading = false;
  bool get isOtpLoading => _isOtpLoading;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future<bool> login(BuildContext context) async {
    _isLoginLoading = true;
    _setLoading(true);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar(context, "Please fill in all fields.");
      _isLoginLoading = false;
      _setLoading(false);
      return false;
    }

    try {
      // FakeStore API uses usernames like 'mor_2314' and password '83r5^_'.
      // If the email field contains 'mor_2314' (or other FakeStore users), we call their API.
      // Otherwise, we do a successful mock login to make the app easy to test.
      if (!email.contains('@') && email.length > 3) {
        final Map<String, dynamic> body = {
          'username': email,
          'password': password,
        };
        final response = await ApiService.login(body: body);
        if (response != null && response is Map && response.containsKey('token')) {
          final token = response['token'];
          await StorageService.saveAccessToken(token);
          _authService.login(email, 'Buy a Product');
        } else if (response is String) {
          await StorageService.saveAccessToken(response);
          _authService.login(email, 'Buy a Product');
        } else {
          throw Exception("Invalid response from Fake Store API login.");
        }
      } else {
        // Mock successful login for standard email accounts
        await StorageService.saveAccessToken("mock_access_token_12345");
        _authService.login(email, 'Buy a Product');
      }

      _showSnackbar(context, "Login Successful");
      _isLoginLoading = false;
      _setLoading(false);
      notifyListeners();
      return true;
    } catch (e) {
      _showSnackbar(context, e.toString().replaceAll("Exception: ", ""));
      _isLoginLoading = false;
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signup(BuildContext context) async {
    _isSignupLoading = true;
    _setLoading(true);

    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showSnackbar(context, "Please fill in all fields.");
      _isSignupLoading = false;
      _setLoading(false);
      return false;
    }

    try {
      // Simulate signup delay
      await Future.delayed(const Duration(milliseconds: 800));
      _authService.setUserEmail(email);

      _showSnackbar(context, "Signup Successful. Code sent to email.");
      _isSignupLoading = false;
      _setLoading(false);
      return true;
    } catch (e) {
      _showSnackbar(context, e.toString());
      _isSignupLoading = false;
      _setLoading(false);
      return false;
    }
  }

  Future<bool> verifyOtp(BuildContext context) async {
    _isOtpLoading = true;
    _setLoading(true);

    final otp = otpController.text.trim();
    if (otp.length < 4) {
      _showSnackbar(context, "Please enter a valid 4-digit code.");
      _isOtpLoading = false;
      _setLoading(false);
      return false;
    }

    try {
      await Future.delayed(const Duration(milliseconds: 600));
      _showSnackbar(context, "Verification Successful. You can log in now.");
      _isOtpLoading = false;
      _setLoading(false);
      return true;
    } catch (e) {
      _showSnackbar(context, e.toString());
      _isOtpLoading = false;
      _setLoading(false);
      return false;
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    otpController.dispose();
    super.dispose();
  }
}
