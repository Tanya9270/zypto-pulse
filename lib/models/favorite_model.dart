class FavoriteModel {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final double marketCap;
  final double priceChangePercentage24h;
  final String imageUrl;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.marketCap,
    required this.priceChangePercentage24h,
    required this.imageUrl,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      currentPrice: json['current_price']?.toDouble() ?? 0.0,
      marketCap: json['market_cap']?.toDouble() ?? 0.0,
      priceChangePercentage24h: json['price_change_percentage_24h']?.toDouble() ?? 0.0,
      imageUrl: json['image_url'] ?? '',
    );
  }
}
