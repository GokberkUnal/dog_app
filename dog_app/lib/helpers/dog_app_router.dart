import 'package:dog_app/views/mainScreen/bloc/main_screen_bloc.dart';
import 'package:dog_app/views/mainScreen/main_screen.dart';
import 'package:dog_app/views/splashScreen/bloc/splash_screen_bloc.dart';
import 'package:dog_app/views/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DogAppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/splashscreen':
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (context) => SplashScreenBloc(), // İkinci sayfada kullanılacak Bloc'u tanımlayın
            child: const SplashScreen(),
          ),);
      case '/mainscreen':
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (context) => MainScreenBloc(), // İkinci sayfada kullanılacak Bloc'u tanımlayın
            child: const MainScreen(),
          ),);
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Sayfa Bulunamadı'),
            ),
          ),
        );
    }
  }
}