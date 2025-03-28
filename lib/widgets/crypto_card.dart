import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/crypto_model.dart';
import '../providers/auth_provider.dart';
import '../services/favorite_service.dart';

class CryptoCard extends ConsumerWidget {
  final CryptoModel crypto;
  final bool isFavorite;

  const CryptoCard({
    super.key,
    required this.crypto,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isLoggedIn = ref.watch(authStateProvider) != null;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final priceFormatted = '\$${crypto.currentPrice.toStringAsFixed(2)}';
    final marketCapFormatted = _formatMarketCap(crypto.marketCap);
    final priceChangeFormatted =
        crypto.priceChangePercentage24h?.toStringAsFixed(2) ?? 'N/A';
    final priceChangeColor = crypto.priceChangePercentage24h != null
        ? crypto.priceChangePercentage24h! >= 0
            ? Colors.green
            : Colors.red
        : Colors.grey;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showCryptoDetails(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      crypto.image,
                      width: 40,
                      height: 40,
                      errorBuilder: (_, __, ___) => Icon(
                        Icons.currency_bitcoin,
                        size: 40,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          crypto.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          crypto.symbol.toUpperCase(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        priceFormatted,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$priceChangeFormatted%',
                        style: TextStyle(
                          color: priceChangeColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Market Cap: $marketCapFormatted',
                    style: theme.textTheme.bodySmall,
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.star : Icons.star_border,
                      color: isDarkMode ? Colors.amber[200] : Colors.amber[800],
                    ),
                    onPressed: isLoggedIn
                        ? () => _handleFavoriteAction(ref, context)
                        : () => _showLoginPrompt(context),
                    tooltip: isLoggedIn
                        ? isFavorite
                            ? 'Remove favorite'
                            : 'Add to favorites'
                        : 'Login to manage favorites',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatMarketCap(double? marketCap) {
    if (marketCap == null) return 'N/A';
    if (marketCap >= 1e12) return '\$${(marketCap / 1e12).toStringAsFixed(2)}T';
    if (marketCap >= 1e9) return '\$${(marketCap / 1e9).toStringAsFixed(2)}B';
    if (marketCap >= 1e6) return '\$${(marketCap / 1e6).toStringAsFixed(2)}M';
    return '\$${marketCap.toStringAsFixed(2)}';
  }

  Future<void> _handleFavoriteAction(
      WidgetRef ref, BuildContext context) async {
    final token = ref.read(authStateProvider)?.accessToken;
    if (token == null) return;

    try {
      if (isFavorite) {
        // Implement remove favorite logic if needed
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Removed from favorites')),
        );
      } else {
        await FavoriteService.addFavorite(
          token: token,
          cryptoId: crypto.id,
          name: crypto.name,
          symbol: crypto.symbol,
          currentPrice: crypto.currentPrice,
          marketCap: crypto.marketCap,
          priceChangePercentage24h: crypto.priceChangePercentage24h,
          imageUrl: crypto.image,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added to favorites!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _showLoginPrompt(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Please login to manage favorites'),
        action: SnackBarAction(
          label: 'Login',
          onPressed: () => Navigator.pushNamed(context, '/login'),
        ),
      ),
    );
  }

  void _showCryptoDetails(BuildContext context) {
    // Implement navigation to details screen
  }
}
