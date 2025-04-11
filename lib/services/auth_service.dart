import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:healthcare/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthService {
  final String baseUrl = 'http://localhost:3000/auth';
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  // ฟังก์ชัน Sign Up
  Future<String?> signUp(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/signup');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );

      if (response.statusCode == 201) {
        return null; // Sign Up สำเร็จ
      } else {
        final message = jsonDecode(response.body)['message'] ?? 'Sign up failed.';
        return message;
      }
    } catch (e) {
      print('Sign Up Error: $e');
      return 'Failed to connect to the server. Please try again.';
    }
  }

  // ฟังก์ชัน Login
  Future<String?> login(BuildContext context, String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    try {
      print('Sending POST request to $url with body: {email: $email, password: $password}');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['token'] == null || data['user'] == null) {
          print('Invalid response format: ${response.body}');
          return 'Invalid server response.';
        }

        final token = data['token'];
        print('Login successful: Token = $token');

        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        await authProvider.login(token);
        print('AuthProvider updated successfully.');

        return null; // Login สำเร็จ
      } else {
        final errorMessage = jsonDecode(response.body)['message'] ?? 'Login failed.';
        print('Login failed: $errorMessage');
        return errorMessage;
      }
    } catch (e) {
      print('Failed to connect to server: $e');
      return 'Failed to connect to the server. Please check your internet connection.';
    }
  }

  // ฟังก์ชันเรียก Protected API
  Future<void> getProtectedData() async {
    try {
      final token = await secureStorage.read(key: 'token');
      print('Token retrieved: $token');

      if (token == null) {
        throw Exception('No token found.');
      }

      final url = Uri.parse('$baseUrl/protected');
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Protected Data: ${data['message']}');
      } else {
        print('Error fetching protected data: ${response.statusCode} - ${response.body}');
      }
    } catch (e) {
      print('Error fetching protected data: $e');
    }
  }

  // ฟังก์ชัน Logout
  Future<void> logout(BuildContext context) async {
    try {
      await secureStorage.delete(key: 'token');
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.logout();
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    } catch (e) {
      print('Error during logout: $e');
    }
  }
}
