import 'dart:io';

import 'package:flutter/foundation.dart';

void main() async {
  final envFile = File('.env');
  final outputFile = File('lib/core/secrets.dart');

  if (!envFile.existsSync()) {
    if (kDebugMode) {
      print('❌ Arquivo .env não encontrado.');
    }
    exit(1);
  }

  final lines = await envFile.readAsLines();
  final vars = <String, String>{};

  for (var line in lines) {
    if (line.trim().isEmpty || line.trim().startsWith('#')) continue;
    final parts = line.split('=');
    if (parts.length == 2) {
      vars[parts[0].trim()] = parts[1].trim();
    }
  }

  final buffer = StringBuffer();
  buffer.writeln(
    '// 🔒 Gerado automaticamente por env_generator_from_dotenv.dart',
  );
  buffer.writeln('class Secrets {');
  vars.forEach((key, value) {
    buffer.writeln("  static const String ${_camelCase(key)} = '$value';");
  });
  buffer.writeln('}');

  await outputFile.writeAsString(buffer.toString());
  if (kDebugMode) {
    print('✅ lib/core/secrets.dart gerado com sucesso.');
  }
}

String _camelCase(String input) {
  final parts = input.toLowerCase().split('_');
  return parts.first +
      parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
}
