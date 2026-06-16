import 'package:flutter/material.dart';

class CryptoTrackerApp extends StatelessWidget {
  const CryptoTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Crypto Tracker',
      home: Scaffold(
        body: Center(child: Text('Crypto Tracker — skeleton')),
      ),
    );
  }
}
