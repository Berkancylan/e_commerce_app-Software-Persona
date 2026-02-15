import 'package:flutter/material.dart';
import 'package:e_commerce_app/services/address_provider.dart';
import 'package:e_commerce_app/services/payment_provider.dart';
import 'package:e_commerce_app/services/product_provider.dart';
import 'package:e_commerce_app/views/main_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Uygulamanın en tepesine veri havuzumuzu (Provider) koyuyoruz
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => AddressProvider())
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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: MainScreen(),
    );
  }
}
