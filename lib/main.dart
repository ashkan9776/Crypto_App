import 'package:crypto_app/provider/crypto_data_provider.dart';
import 'package:crypto_app/provider/market_view_provider.dart';
import 'package:crypto_app/presentation/ui/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MarketViewProvider()),
        ChangeNotifierProvider(create: (context) => CryptoDataProvider())
      ],
      child: const MyApp(),
    ));

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto App',
      home: SplashScreen(),
    );
  }
}
