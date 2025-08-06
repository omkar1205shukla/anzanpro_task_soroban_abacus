// import 'package:flutter/material.dart';

// import 'presentation/pages/soroban_page.dart';

// void main() {
//   runApp(const SorobanApp());
// }

// class SorobanApp extends StatelessWidget {
//   const SorobanApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Soroban Abacus',
//       theme: ThemeData(
//         useMaterial3: true,
//         fontFamily: 'Roboto',
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
//       ),
//       home: SorobanPage(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'presentation/pages/soroban_page.dart';

/// Entry point of the Soroban App
void main() {
  runApp(const SorobanApp());
}

/// Root widget of the application
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
