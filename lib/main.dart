import 'package:flutter/material.dart';
import 'package:motivational_quotes_app/favorites_screen.dart';
import 'package:motivational_quotes_app/home_screen.dart';
import 'package:motivational_quotes_app/quote_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_)=> QuoteProvider()),
    ],
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/favorites': (_) => FavoritesScreen()
      },
    );
  }
}


