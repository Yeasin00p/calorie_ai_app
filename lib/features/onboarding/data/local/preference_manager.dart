import 'dart:convert';

import 'package:calorie_ai_app/features/onboarding/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String _userDataKey = 'userData';
  static const _onboardingKey = 'onboarding_complete';

  final SharedPreferences preferences;
  PreferenceManager(this.preferences);

  Future<void> setOnboardingComplete() async {
    await preferences.setBool(_onboardingKey, true);
  }

  bool get isOnboardingComplete => preferences.getBool(_onboardingKey) ?? false;

  Future<void> saveUserData(UserData data) async {
    final userDataJson = jsonEncode(data.toJson());
    await preferences.setString(_userDataKey, userDataJson);
  }

  UserData? getUserData() {
    final userDataJson = preferences.getString(_userDataKey);
    if (userDataJson != null) {
      final Map<String, dynamic> userDataMap = jsonDecode(userDataJson);
      return UserData.fromJson(userDataMap);
    }
    return null;
  }

  Future<void> clearUserData() async {
    await preferences.remove(_userDataKey);
  }
}
