import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppKeys {
  static String get marvelPublicKey {
    if (kIsWeb) {
      const String key = String.fromEnvironment('MARVEL_PUBLIC_KEY');
      return key.isNotEmpty ? key : 'd4eddb05b0f08ea9c003cbde52569ca3';
    } else {
      return dotenv.env['MARVEL_PUBLIC_KEY'] ??
          'd4eddb05b0f08ea9c003cbde52569ca3';
    }
  }

  static String get marvelPrivateKey {
    if (kIsWeb) {
      const String key = String.fromEnvironment('MARVEL_PRIVATE_KEY');
      return key.isNotEmpty ? key : 'fa00cb0934d942680d1195f2e9e6adcd75c56e18';
    } else {
      return dotenv.env['MARVEL_PRIVATE_KEY'] ??
          'fa00cb0934d942680d1195f2e9e6adcd75c56e18';
    }
  }

  static String get marvelBaseUrl => 'https://gateway.marvel.com/v1/public/';
}
