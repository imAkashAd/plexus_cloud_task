import 'package:plexus_task/core/services/storage_service.dart';

class AuthService {
  static const String _accountTypeKey = 'account_type';
  static const String _userEmailKey = 'user_email';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userIdKey = 'user_id';

  String _onboardingKeyFor(String email) {
    return 'onboarding_completed_${email.trim().toLowerCase()}';
  }

  void setAccountType(String type) {
    StorageService.sharedPreferences?.setString(_accountTypeKey, type);
  }

  void setUserEmail(String email) {
    StorageService.sharedPreferences?.setString(_userEmailKey, email.trim());
  }

  String? getAccountType() {
    return StorageService.sharedPreferences?.getString(_accountTypeKey);
  }

  void login(String email, String? accountType) {
    setUserEmail(email);
    if (accountType != null) {
      setAccountType(accountType);
    }
    StorageService.sharedPreferences?.setBool(_isLoggedInKey, true);
  }

  bool isLoggedIn() {
    return StorageService.sharedPreferences?.getBool(_isLoggedInKey) ?? false;
  }

  bool hasCompletedOnboarding({String? email}) {
    final currentEmail = (email ?? getUserEmail())?.trim();
    if (currentEmail == null || currentEmail.isEmpty) {
      return false;
    }
    return StorageService.sharedPreferences?.getBool(_onboardingKeyFor(currentEmail)) ?? false;
  }

  void markOnboardingCompleted({String? email}) {
    final currentEmail = (email ?? getUserEmail())?.trim();
    if (currentEmail == null || currentEmail.isEmpty) {
      return;
    }
    StorageService.sharedPreferences?.setBool(_onboardingKeyFor(currentEmail), true);
  }

  void resetSession() {
    StorageService.sharedPreferences?.remove(_accountTypeKey);
    StorageService.sharedPreferences?.remove(_userEmailKey);
    StorageService.sharedPreferences?.remove(_isLoggedInKey);
    StorageService.sharedPreferences?.remove(_userIdKey);
    StorageService.removeAccessToken();
    StorageService.removeRefreshToken();
  }

  void logout() {
    resetSession();
  }

  String? getUserEmail() {
    return StorageService.sharedPreferences?.getString(_userEmailKey);
  }

  void setUserId(dynamic userId) {
    StorageService.sharedPreferences?.setString(_userIdKey, userId.toString());
  }

  dynamic getUserId() {
    return StorageService.sharedPreferences?.getString(_userIdKey);
  }
}
