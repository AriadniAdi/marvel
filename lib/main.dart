import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marvel_app/core/injector.dart';
import 'package:marvel_app/core/theme/app_theme.dart';
import 'package:marvel_app/presentation/home/home_screen.dart';
import 'package:marvel_app/routes/app_router.dart';
import 'package:marvel_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  if (!kIsWeb) {
    await dotenv.load(fileName: ".env");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marvel Heroes App',
      theme: buildAppTheme(),
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: AppRouter.generateRoute,
      home: const HomeScreen(),
    );
  }
}
