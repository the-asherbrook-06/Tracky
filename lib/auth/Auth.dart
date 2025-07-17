// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  Map<String, dynamic>? _userDetails;
  bool _isAuthenticated = false;
  String? _userId;

  String? get userId => _userId;
  bool get isAuthenticated => _isAuthenticated;
  Map<String, dynamic>? get userDetails => _userDetails;

  Future<void> fetchUserDetails(BuildContext context) async {
    if (_userId == null) return;

    final url = Uri.parse('https://tracky-backend-gixb.onrender.com/api/user/$_userId');

    try {
      final response = await http.get(url);

      debugPrint("User fetch status: ${response.statusCode}");
      debugPrint("User fetch body: ${response.body}");

      if (response.statusCode == 200) {
        _userDetails = jsonDecode(response.body);
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to fetch user details")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error fetching user data.")),
      );
    }
  }

  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final url = Uri.parse('https://tracky-backend-gixb.onrender.com/api/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': name,
          'email': email,
          'password': password,
        }),
      );

      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) && data['message'] == 'User registered') {
        _userId = data['userId'];
        _isAuthenticated = true;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User registered successfully!")),
        );

        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${data['error'] ?? 'Registration failed'}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong. Please try again.")),
      );
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final url = Uri.parse('https://tracky-backend-gixb.onrender.com/api/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      debugPrint("Response status: ${response.statusCode}");
      debugPrint("Response body: ${response.body}");

      final data = jsonDecode(response.body);

      if ((response.statusCode == 200 || response.statusCode == 201) && data['message'] == 'Login successful') {
        _userId = data['userId'];
        _isAuthenticated = true;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User logged in successfully!")),
        );

        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("${data['error'] ?? 'login failed'}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Something went wrong. Please try again.")),
      );
    }
  }

  void logoutUser(BuildContext context) {
    _userId = null;
    _isAuthenticated = false;
    notifyListeners();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You've been logged out!")),
    );

    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }
}
