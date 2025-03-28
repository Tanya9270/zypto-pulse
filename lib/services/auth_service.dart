import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthService {
  static const String _baseUrl = 'https://api.fluttercrypto.agpro.co.in';
  static const String _defaultUserRole = 'bf6c3d87-3564-43ac-a172-5614bbc40811';

  static Future<UserModel> signUp({
    required String email,
    required String password,
    required String firstName,
  }) async {
    try {
      if (kDebugMode) {
        print('Attempting signup with email: $email');
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'first_name': firstName,
          'role': _defaultUserRole
        }),
      );

      if (kDebugMode) {
        print('Signup response: ${response.statusCode} - ${response.body}');
      }

      // Handle successful response (200-299) even with empty body
      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Proceed with login since signup was successful
        return await login(email: email, password: password);
      }

      // Handle error responses
      dynamic responseData;
      if (response.body.isNotEmpty) {
        try {
          responseData = json.decode(response.body);
        } catch (e) {
          throw Exception('Invalid server response format');
        }
      }

      if (responseData != null && responseData is Map) {
        if (responseData['errors']?[0]?['extensions']?['code'] ==
            'RECORD_NOT_UNIQUE') {
          throw Exception(
              'Email already exists. Please use a different email or login.');
        } else {
          throw Exception(
              responseData['errors']?[0]?['message'] ?? 'Signup failed');
        }
      } else {
        throw Exception('Signup failed with status ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Signup error: $e');
      }
      rethrow;
    }
  }

  static Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        dynamic responseData;
        try {
          responseData = json.decode(response.body);
        } catch (e) {
          throw Exception('Invalid login response format');
        }

        return UserModel(
          email: email,
          firstName: '', // Will be fetched from profile
          accessToken: responseData['data']?['access_token'] ?? '',
          refreshToken: responseData['data']?['refresh_token'] ?? '',
          expiresIn: responseData['data']?['expires'] ?? 0,
        );
      } else {
        throw Exception('Login failed with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserModel> getUserProfile(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/me'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        dynamic responseData;
        try {
          responseData = json.decode(response.body);
        } catch (e) {
          throw Exception('Invalid profile response format');
        }

        return UserModel(
          email: responseData['data']?['email'] ?? '',
          firstName: responseData['data']?['first_name'] ?? '',
          accessToken: token,
        );
      } else {
        throw Exception(
            'Failed to fetch profile with status ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
