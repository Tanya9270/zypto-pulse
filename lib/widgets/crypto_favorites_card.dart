import 'package:flutter/material.dart';
import '../models/favorite_model.dart';

class CryptoFavoritesCard extends StatelessWidget {
  final FavoriteModel favorite;
  final VoidCallback onDelete;
  final bool isDeleting;

  const CryptoFavoritesCard({
    super.key,
    required this.favorite,
    required this.onDelete,
    required this.isDeleting,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final priceChangeColor =
        favorite.priceChangePercentage24h >= 0 ? Colors.green : Colors.red;

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
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 20,
                  child: Image.network(
                    favorite.imageUrl,
                    errorBuilder: (_, __, ___) => Icon(
                      Icons.currency_bitcoin,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favorite.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      favorite.symbol.toUpperCase(),
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
                    '\$${favorite.currentPrice.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${favorite.priceChangePercentage24h.toStringAsFixed(2)}%',
                    style: TextStyle(
                      color: priceChangeColor,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: isDeleting
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        Icons.delete_outline,
                        color: isDarkMode ? Colors.red[200] : Colors.red[800],
                      ),
                onPressed: isDeleting ? null : onDelete,
                tooltip: 'Remove from favorites',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCryptoDetails(BuildContext context) {
    // Implement navigation to details screen
  }
}
