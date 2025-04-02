import 'package:flutter/material.dart';
import 'package:marvel_app/presentation/details/hero_detail_screen.dart';
import 'package:marvel_app/presentation/home/home_screen.dart';
import 'package:marvel_app/presentation/splash_screen/splash_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.heroDetailScreen:
        final args = settings.arguments as int;
        // ignore: unnecessary_null_comparison
        if (args == null) {
          return MaterialPageRoute(builder: (_) => ErrorRoute());
        }
        return MaterialPageRoute(
          builder: (_) => HeroDetailScreen(heroId: args),
        );
      default:
        return MaterialPageRoute(builder: (_) => ErrorRoute());
    }
  }
}

class ErrorRoute extends StatelessWidget {
  const ErrorRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Página não encontrada')));
  }
}
