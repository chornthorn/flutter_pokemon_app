class AppData {
  AppData._();

  static const bool environment = true;
  static const String apiVersion = 'v1';
  static const String companyName = 'E Lythong Co Ltd.,';
  static const String fontFamily = 'NatoSansKhmer';
  static const appPadding = 16.00;
  static const double hug = 60;

  static Map<String, dynamic> get env {
    if (environment) {
      return dev;
    } else {
      return prod;
    }
  }

  static const Map<String, dynamic> dev = {
    'baseUrl': 'https://gist.githubusercontent.com/hungps/',
  };
  static const Map<String, dynamic> prod = {
    'baseUrl': 'http://localhost:3000/api/',
  };

  static const duration = 60; // 60 seconds
  static const receiveTimeout = 15000; // 15 seconds
  static const connectTimeout = 15000; // 15 seconds
  static const sendTimeout = 15000; // 15 seconds

  // shares preference key
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';
  static const String userInfoKey = 'user_info';
  static const String languageKey = 'language';

  // routes path
  static const String login = 'auth/login';
  static const String register = 'auth/register';
  static const String refreshToken = 'auth/refresh';

  // meta
  static const String errorMessage = 'Something went wrong';
}
