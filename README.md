# ZyptoPulse - Cryptocurrency Tracker


A Flutter application for tracking cryptocurrency prices with real-time updates and favorites management.

---

## Table of Contents
- [Features](#features)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Setup](#setup)
- [Configuration](#configuration)
- [API Documentation](#api-documentation)
  - [CoinGecko API](#coingecko-api)
  - [API Interactions](#api-interactions)
- [Authentication](#authentication)
- [Favorites System](#favorites-system)
- [Running Tests](#running-tests)
- [Build Instructions](#build-instructions)
- [Contributing](#contributing)
- [License](#license)

---

## Features

- 📊 Real-time cryptocurrency price tracking  
- 🔐 User authentication (JWT)  
- ⭐ Favorite coins management  
- 🌓 Dark/Light theme support  
- 📱 Responsive design for mobile/tablet  

---

## Installation

### Prerequisites

Ensure the following are installed on your system:
- **Flutter SDK** (>= 3.0.0)
- **Dart SDK** (>= 2.17.0)
- **Android Studio/Xcode** (for mobile development)

### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/yourusername/zyptopulse.git
   cd zyptopulse
### Install dependencies:

bash
Copy
Edit
flutter pub get

### Run the app:

bash
Copy
Edit
flutter run

### Configuration
Create a .env file in the root directory and add the following:

.env
####  API Configuration
API_BASE_URL=https://api.fluttercrypto.agpro.co.in
COINGECKO_API_URL=https://api.coingecko.com/api/v3

####  Auth Configuration
JWT_SECRET=your_jwt_secret_key
TOKEN_EXPIRY=3600 # 1 hour in seconds

####  API Documentation
###CoinGecko API (Public)
-Endpoint:
-GET /coins/markets?vs_currency=usd&order=market_cap_desc&per_page=20&page=1

### API Interactions
Adding a Favorite
'''dart
await FavoriteService.addFavorite(
  token: accessToken,
  cryptoId: 'bitcoin',
  name: 'Bitcoin',
  symbol: 'BTC',
  currentPrice: 42000,
  imageUrl: 'https://.../bitcoin.png'
);
### Deleting a Favorite
'''dart
await FavoriteService.deleteFavorite(token, favoriteId);
#### Authentication
- JWT Authentication is used for secure access to user-specific features.

- Token expiry is set to 1 hour by default and can be configured in the .env file.

### Favorites System
- Users can add and remove their favorite cryptocurrencies.

- The favorites are stored securely and displayed in a dedicated section of the app.

#### Running Tests
###Run all tests:
'''bash
Copy
Edit
flutter test
### Run a specific test file:
'''bash
Copy
Edit
flutter test test/auth_test.dart
### Sample Test:
'''dart

test('Successful login returns token', () async {
  final mockClient = MockClient((request) async {
    return Response('{"access_token": "test_token"}', 200);
  });
  
  final authService = AuthService(client: mockClient);
  final result = await authService.login('test@email.com', 'password');
  
  expect(result.accessToken, equals('test_token'));
});
#### Build Instructions
### Android
'''bash
flutter build apk --release
### iOS
'''bash

flutter build ios --release
### Web
'''bash
flutter build web --release
