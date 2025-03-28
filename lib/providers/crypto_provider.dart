import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/crypto_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final cryptoListProvider = FutureProvider<List<CryptoModel>>((ref) async {
  final response = await http.get(
    Uri.parse(
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => CryptoModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load cryptocurrencies');
  }
});
