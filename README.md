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
git clone https://github.com/yourusername/zyptopulse.git
cd zyptopulse

# Install dependencies
flutter pub get

# Run the app
flutter run
Configuration
Create a .env file in the root directory:

env
Copy
# API Configuration
API_BASE_URL=https://api.fluttercrypto.agpro.co.in
COINGECKO_API_URL=https://api.coingecko.com/api/v3

# Auth Configuration
JWT_SECRET=your_jwt_secret_key
TOKEN_EXPIRY=3600 # 1 hour in seconds
API Documentation
CoinGecko API (Public)
Endpoint:
GET /coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1

Example Dart Implementation:

dart
Copy
final response = await http.get(
  Uri.parse('$coingeckoApiUrl/coins/markets?vs_currency=usd'),
  headers: {'Accept': 'application/json'},
);
Response Structure:

json
Copy
[
  {
    "id": "bitcoin",
    "symbol": "btc",
    "name": "Bitcoin",
    "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png",
    "current_price": 42000.00,
    "market_cap": 800000000000,
    "price_change_percentage_24h": 2.5
  }
]
Backend API (Protected)
Base URL: https://api.fluttercrypto.agpro.co.in

Endpoint	Method	Description
/auth/login	POST	User login
/auth/register	POST	User registration
/items/crypto_favorites	GET	Get user favorites
/items/crypto_favorites	POST	Add favorite
/items/crypto_favorites/:id	DELETE	Remove favorite
Authentication Header:

dart
Copy
headers: {
  'Authorization': 'Bearer $accessToken',
  'Content-Type': 'application/json',
}
Authentication
JWT Flow
mermaid
Copy
sequenceDiagram
    participant User
    participant App
    participant Server
    
    User->>App: Enters credentials
    App->>Server: POST /auth/login {email, password}
    Server-->>App: JWT Tokens (access + refresh)
    App->>App: Store tokens securely
    App->>Server: API requests with JWT
    Server-->>App: Protected data
Token Management Code
Storing Tokens:

dart
Copy
const storage = FlutterSecureStorage();
await storage.write(key: 'access_token', value: accessToken);
await storage.write(key: 'refresh_token', value: refreshToken);
Refreshing Tokens:

dart
Copy
final response = await http.post(
  Uri.parse('$apiBaseUrl/auth/refresh'),
  headers: {'Authorization': 'Bearer $refreshToken'},
);
Favorites System
Data Structure
dart
Copy
class FavoriteModel {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final String imageUrl;
  
  // Constructor and methods...
}
API Interactions
Adding a Favorite:

dart
Copy
await FavoriteService.addFavorite(
  token: accessToken,
  cryptoId: 'bitcoin',
  name: 'Bitcoin',
  symbol: 'BTC',
  currentPrice: 42000,
  imageUrl: 'https://.../bitcoin.png'
);
Deleting a Favorite:

dart
Copy
await FavoriteService.deleteFavorite(token, favoriteId);
Running Tests
bash
Copy
# Run all tests
flutter test

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

bash
Copy
flutter build apk --release
iOS:

bash
Copy
flutter build ios --release
Web:

bash
Copy
flutter build web --release
