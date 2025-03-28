# ZyptoPulse - Cryptocurrency Tracker

![App Screenshot](https://example.com/screenshot.png)

A Flutter application for tracking cryptocurrency prices with real-time updates and favorites management.

## Table of Contents
- [Features](#features)
- [Installation](#installation)
- [Configuration](#configuration)
- [API Documentation](#api-documentation)
- [Authentication](#authentication)
- [Favorites System](#favorites-system)
- [Running Tests](#running-tests)
- [Build Instructions](#build-instructions)
- [Contributing](#contributing)
- [License](#license)

## Features

- 📊 Real-time cryptocurrency price tracking
- 🔐 User authentication (JWT)
- ⭐ Favorite coins management
- 🌓 Dark/Light theme support
- 📱 Responsive design for mobile/tablet

## Installation

### Prerequisites
- Flutter SDK (>= 3.0.0)
- Dart SDK (>= 2.17.0)
- Android Studio/Xcode (for mobile development)


# Clone the repository
- git clone https://github.com/yourusername/zyptopulse.git
- cd zyptopulse

# Install dependencies
- flutter pub get

# Run the app
- flutter run
- Configuration
- Create a .env file in the root directory:

env
Copy
# API Configuration
- API_BASE_URL=https://api.fluttercrypto.agpro.co.in
- COINGECKO_API_URL=https://api.coingecko.com/api/v3

# Auth Configuration
- JWT_SECRET=your_jwt_secret_key
- TOKEN_EXPIRY=3600 # 1 hour in seconds
- API Documentation
- CoinGecko API (Public)
- - Endpoint:
- GET /coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1


- - API Interactions
- Adding a Favorite:

- dart
- Copy
- await FavoriteService.addFavorite(
-   token: accessToken,
-   cryptoId: 'bitcoin',
-   name: 'Bitcoin',
-   symbol: 'BTC',
-   currentPrice: 42000,
-   imageUrl: 'https://.../bitcoin.png'
- );
- - Deleting a Favorite:

- dart
- Copy
- await FavoriteService.deleteFavorite(token, favoriteId);
- Running Tests
- bash
- Copy
- - - # Run all tests
- flutter test

# Run specific test file
flutter test test/auth_test.dart
Sample Test:

dart
Copy
test('Successful login returns token', () async {
  final mockClient = MockClient((request) async {
    return Response('{"access_token": "test_token"}', 200);
  });
  
  final authService = AuthService(client: mockClient);
  final result = await authService.login('test@email.com', 'password');
  
  expect(result.accessToken, equals('test_token'));
});
Build Instructions
Android:

bash """
Copy
flutter build apk --release
iOS:

bash """
Copy
flutter build ios --release
Web:

bash
Copy
flutter build web --release
