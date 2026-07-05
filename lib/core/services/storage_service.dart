import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  static SharedPreferences? sharedPreferences;

  // ================= INITIALIZE =================

  static Future<void> init() async {

    sharedPreferences =
        await SharedPreferences.getInstance();
  }

  // ================= STORAGE KEYS =================

  static const String accessTokenKey =
      "accessToken";

  static const String refreshTokenKey =
      "refreshToken";

  static const String userIdKey =
      "userId";

  // ================= SAVE ACCESS TOKEN =================

  static Future<void> saveAccessToken(
    String accessToken,
  ) async {

    await sharedPreferences?.setString(
      accessTokenKey,
      accessToken,
    );
  }

  // ================= SAVE REFRESH TOKEN =================

  static Future<void> saveRefreshToken(
    String refreshToken,
  ) async {

    await sharedPreferences?.setString(
      refreshTokenKey,
      refreshToken,
    );
  }

  // ================= SAVE USER ID =================

  static Future<void> saveUserId(
    String userId,
  ) async {

    await sharedPreferences?.setString(
      userIdKey,
      userId,
    );
  }

  // ================= GET ACCESS TOKEN =================

  static String? getAccessToken() {

    return sharedPreferences?.getString(
      accessTokenKey,
    );
  }

  // ================= GET REFRESH TOKEN =================

  static String? getRefreshToken() {

    return sharedPreferences?.getString(
      refreshTokenKey,
    );
  }

  // ================= GET USER ID =================

  static String? getUserId() {

    return sharedPreferences?.getString(
      userIdKey,
    );
  }

  // ================= CHECK LOGIN =================

  static bool isLoggedIn() {

    final accessToken =
        sharedPreferences?.getString(
          accessTokenKey,
        );

    return accessToken != null &&
        accessToken.isNotEmpty;
  }

  // ================= REMOVE ACCESS TOKEN =================

  static Future<void> removeAccessToken() async {

    await sharedPreferences?.remove(
      accessTokenKey,
    );
  }

  // ================= REMOVE REFRESH TOKEN =================

  static Future<void> removeRefreshToken() async {

    await sharedPreferences?.remove(
      refreshTokenKey,
    );
  }

  // ================= REMOVE USER ID =================

  static Future<void> removeUserId() async {

    await sharedPreferences?.remove(
      userIdKey,
    );
  }

  // ================= LOGOUT =================

  static Future<void> logoutUser() async {

    await removeAccessToken();

    await removeRefreshToken();

    await removeUserId();
  }

  // ================= CLEAR ALL STORAGE =================

  static Future<void> clearAllStorage() async {

    await sharedPreferences?.clear();
  }
}