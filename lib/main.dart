import 'package:excuse_generator/pages/create_excuse_page.dart';
import 'package:excuse_generator/pages/favorites_page.dart';
import 'package:excuse_generator/pages/history_page.dart';
import 'package:excuse_generator/pages/home_page.dart';
import 'package:excuse_generator/pages/stats_page.dart';
import 'package:excuse_generator/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:excuse_generator/services/excuse_service.dart';

import 'Splash.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExcuseService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excuse Generator',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      // Set SplashScreen as the initial route
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomePage(),
        '/favorites': (context) => FavoritesPage(
            favorites: Provider.of<ExcuseService>(context).getFavorites()),
        '/history': (context) => const HistoryPage(),
        '/stats': (context) => const StatsPage(),
        '/create': (context) => const CreateExcusePage(),
      },
    );
  }
}
