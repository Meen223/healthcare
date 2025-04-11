import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider with ChangeNotifier {
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  String? _token;
  bool _isAuthenticated = false;

  // Getter สำหรับตรวจสอบสถานะการล็อกอิน
  bool get isAuthenticated => _isAuthenticated;

  // ฟังก์ชันสำหรับดึง Token
  String? get token => _token;

  // ฟังก์ชันสำหรับโหลดสถานะการล็อกอินจาก Secure Storage
  Future<void> loadToken() async {
    try {
      final storedToken = await secureStorage.read(key: 'token');
      if (storedToken != null) {
        _token = storedToken;
        _isAuthenticated = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error loading token: $e');
    }
  }

  // ฟังก์ชันสำหรับตรวจสอบสถานะการล็อกอิน
  Future<void> checkAuthStatus() async {
    await loadToken();
  }

  // ฟังก์ชันสำหรับ Login
  Future<void> login(String token) async {
    try {
      _token = token;
      _isAuthenticated = true;

      // เก็บ Token ลงใน Secure Storage
      await secureStorage.write(key: 'token', value: token);
      print('Token saved: $_token');
      notifyListeners();
    } catch (e) {
      print('Error during login: $e');
    }
  }

  // ฟังก์ชันสำหรับ Logout
  Future<void> logout() async {
    try {
      _token = null;
      _isAuthenticated = false;

      // ลบ Token และข้อมูลทั้งหมดออกจาก Secure Storage
      await secureStorage.deleteAll();
      print('Logged out and storage cleared.');
      notifyListeners();
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
