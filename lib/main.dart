import 'package:flutter/material.dart';

import 'presentation/pages/soroban_page.dart';

void main() {
  runApp(const SorobanApp());
}

class SorobanApp extends StatelessWidget {
  const SorobanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soroban Abacus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: SorobanPage(),
    );
  }
}
