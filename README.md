
# ZyptoPulse - Cryptocurrency Tracker

A Flutter application for tracking cryptocurrency prices with real-time updates and favorites management.

---

## Features

- 📊 Real-time cryptocurrency price tracking  
- 🔐 User authentication (JWT)  
- ⭐ Favorite coins management  
- 🌓 Dark/Light theme support  
- 📱 Responsive design for mobile/tablet  

---

## Installation

```bash
# Prerequisites:
# Ensure the following are installed on your system:
# - Flutter SDK (>= 3.0.0)
# - Dart SDK (>= 2.17.0)
# - Android Studio/Xcode (for mobile development)

# Clone the repository
git clone https://github.com/yourusername/zyptopulse.git
cd zyptopulse

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## Configuration and API Integration

Create a `.env` file in the root directory with the following:

```env
# API Configuration
API_BASE_URL=https://api.fluttercrypto.agpro.co.in
COINGECKO_API_URL=https://api.coingecko.com/api/v3

# Auth Configuration
JWT_SECRET=your_jwt_secret_key
TOKEN_EXPIRY=3600 # 1 hour in seconds
```

The application integrates with the CoinGecko API for fetching real-time cryptocurrency data. A sample API endpoint:  

```text
GET /coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1
```

---

## Functionality and Code Samples

### Adding a Favorite:

```dart
await FavoriteService.addFavorite(
  token: accessToken,
  cryptoId: 'bitcoin',
  name: 'Bitcoin',
  symbol: 'BTC',
  currentPrice: 42000,
  imageUrl: 'https://.../bitcoin.png'
);
```

### Deleting a Favorite:

```dart
await FavoriteService.deleteFavorite(token, favoriteId);
```

---

## Authentication and Favorites System

- The app uses **JWT Authentication** for secure access to user-specific features.  
- Token expiry is set to **1 hour by default** (can be configured in the `.env` file).  
- Users can manage a list of their favorite cryptocurrencies, which are stored securely and displayed in a dedicated section.  

---

## Running Tests and Sample Code

```bash
# Run all tests
flutter test

# Run a specific test file
flutter test test/auth_test.dart
```

Sample test for login functionality:  

```dart
test('Successful login returns token', () async {
  final mockClient = MockClient((request) async {
    return Response('{"access_token": "test_token"}', 200);
  });

  final authService = AuthService(client: mockClient);
  final result = await authService.login('test@email.com', 'password');

  expect(result.accessToken, equals('test_token'));
});
```

---

## Build Instructions

```bash
# Build for Android
flutter build apk --release

# Build for iOS
flutter build ios --release

# Build for Web
flutter build web --release
```
