import 'dart:async';

import 'package:fedya_shashlik/ui/pages/profile/profile.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class UserPreferences {
  UserPreferences._();

  static final UserPreferences _instance = UserPreferences._();

  static UserPreferences getInstance() {
    return _instance;
  }

  Future<void> savePhoneNumber(String phoneNumber) async {
    var prefs = RxSharedPreferences.getInstance();
    await prefs.setString('phoneNumber', phoneNumber);
  }

  Future<String?> getPhoneNumber() async {
    var prefs = RxSharedPreferences.getInstance();
    String? phoneNumber = await prefs.getString('phoneNumber');
    return phoneNumber;
  }

  Future<void> saveFirstName(String firstName) async {
    var prefs = RxSharedPreferences.getInstance();
    await prefs.setString('firstName', firstName);
  }

  Future<String?> getFirstName() async {
    var prefs = RxSharedPreferences.getInstance();
    String? firstName = await prefs.getString('firstName');
    return firstName;
  }

  Future<void> saveLastName(String lastName) async {
    var prefs = RxSharedPreferences.getInstance();
    await prefs.setString('lastName', lastName);
  }

  Future<String?> getLastName() async {
    var prefs = RxSharedPreferences.getInstance();
    String? lastName = await prefs.getString('lastName');
    return lastName;
  }

  Future<String?> getFullName() async {
    String? firstName = await getFirstName();
    String? lastName = await getLastName();
    return (firstName ?? '') + ' ' + (lastName ?? '');
  }

  Future<void> saveDateOfBirth(DateTime? dateOfBirth) async {
    var prefs = RxSharedPreferences.getInstance();
    if (dateOfBirth != null) {
      await prefs.setString('dateOfBirth', dateOfBirth.toIso8601String());
    }
  }

  Future<DateTime?> getDateOfBirth() async {
    var prefs = RxSharedPreferences.getInstance();
    DateTime? date = DateTime.tryParse((await prefs.getString('dateOfBirth') ?? ''));
    return date;
  }

  Future<void> saveMail(String? email) async {
    var prefs = RxSharedPreferences.getInstance();
    if (email != null) {
      await prefs.setString('email', email);
    }
  }

  Future<String?> getMail() async {
    var prefs = RxSharedPreferences.getInstance();
    String? mail = await prefs.getString('email');
    return mail;
  }

  Future<void> saveGender(Gender? gender) async {
    var prefs = RxSharedPreferences.getInstance();
    if (gender != null) {
      await prefs.setString('gender', gender.name);
    }
  }

  Future<Gender?> getGender() async {
    var prefs = RxSharedPreferences.getInstance();
    String? gender = await prefs.getString('gender');
    return gender != null ? Gender.values.firstWhere((element) => element.name == gender) : null;
  }

  Future<void> saveToken(String? token) async {
    var prefs = RxSharedPreferences.getInstance();
    await prefs.setString('token', token!);
  }

  Future<String?> getToken() async {
    var prefs = RxSharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    return token;
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null;
  }

  Future<void> logOut() async {
    var prefs = RxSharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> saveFCMToken(String? token) async {
    var prefs = RxSharedPreferences.getInstance();
    if (token != null) await prefs.setString('fcmToken', token);
  }

  Future<String?> getFCMToken() async {
    var prefs = RxSharedPreferences.getInstance();
    return await prefs.getString('fcmToken');
  }
}
