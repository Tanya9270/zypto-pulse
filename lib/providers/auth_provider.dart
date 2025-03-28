import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<UserModel?> {
  final _storage = const FlutterSecureStorage();

  AuthNotifier() : super(null) {
    loadUser();
  }

  Future<void> loadUser() async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      final email = await _storage.read(key: 'user_email');
      
      if (accessToken != null && email != null) {
        final user = await AuthService.getUserProfile(accessToken);
        state = UserModel(
          email: user.email,
          firstName: user.firstName,
          accessToken: accessToken,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading user: $e');
      }
      await _storage.delete(key: 'access_token');
      await _storage.delete(key: 'refresh_token');
      await _storage.delete(key: 'user_email');
      state = null;
    }
  }

  Future<void> signUp(String email, String password, String firstName) async {
    try {
      final user = await AuthService.signUp(
        email: email,
        password: password,
        firstName: firstName,
      );
      
      final fullUser = await AuthService.getUserProfile(user.accessToken!);
      
      state = UserModel(
        email: fullUser.email,
        firstName: fullUser.firstName,
        accessToken: user.accessToken,
        refreshToken: user.refreshToken,
        expiresIn: user.expiresIn,
      );

      await _storage.write(key: 'access_token', value: user.accessToken);
      await _storage.write(key: 'refresh_token', value: user.refreshToken);
      await _storage.write(key: 'user_email', value: user.email);
    } catch (e) {
      if (kDebugMode) {
        print('Signup error: $e');
      }
      rethrow;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final user = await AuthService.login(
        email: email,
        password: password,
      );
      
      final fullUser = await AuthService.getUserProfile(user.accessToken!);
      
      state = UserModel(
        email: fullUser.email,
        firstName: fullUser.firstName,
        accessToken: user.accessToken,
        refreshToken: user.refreshToken,
        expiresIn: user.expiresIn,
      );

      await _storage.write(key: 'access_token', value: user.accessToken);
      await _storage.write(key: 'refresh_token', value: user.refreshToken);
      await _storage.write(key: 'user_email', value: user.email);
    } catch (e) {
      if (kDebugMode) {
        print('Login error: $e');
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await _storage.delete(key: 'access_token');
      await _storage.delete(key: 'refresh_token');
      await _storage.delete(key: 'user_email');
      state = null;
    } catch (e) {
      if (kDebugMode) {
        print('Logout error: $e');
      }
      rethrow;
    }
  }
}
