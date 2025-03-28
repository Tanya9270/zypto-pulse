import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/favorite_model.dart';

class FavoriteService {
  static const String _baseUrl = 'https://api.fluttercrypto.agpro.co.in';

  static Future<List<FavoriteModel>> getFavorites(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/items/crypto_favorites'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        return jsonList.map((json) => FavoriteModel.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load favorites. Status: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Get favorites error: $e');
      }
      rethrow;
    }
  }

  static Future<void> addFavorite({
    required String token,
    required String cryptoId,
    required String name,
    required String symbol,
    required double currentPrice,
    required double? marketCap,
    required double? priceChangePercentage24h,
    required String imageUrl,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/items/crypto_favorites'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'crypto_id': cryptoId,
          'name': name,
          'symbol': symbol,
          'current_price': currentPrice,
          'market_cap': marketCap,
          'price_change_percentage_24h': priceChangePercentage24h,
          'image_url': imageUrl,
        }),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
            'Failed to add favorite. Status: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Add favorite error: $e');
      }
      rethrow;
    }
  }

  static Future<void> deleteFavorite(String token, String itemId) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl/items/crypto_favorites/$itemId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception(
            'Failed to delete favorite. Status: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Delete favorite error: $e');
      }
      rethrow;
    }
  }
}
