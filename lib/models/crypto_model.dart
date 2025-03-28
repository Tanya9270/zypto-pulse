class CryptoModel {
  final String id;
  final String symbol;
  final String name;
  final double currentPrice;
  final String image;
  final double? marketCap;
  final double? priceChangePercentage24h;

  CryptoModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.currentPrice,
    required this.image,
    this.marketCap,
    this.priceChangePercentage24h,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      currentPrice: json['current_price']?.toDouble() ?? 0.0,
      image: json['image'],
      marketCap: json['market_cap']?.toDouble(),
      priceChangePercentage24h: json['price_change_percentage_24h']?.toDouble(),
    );
  }
}
