// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_train_app/pages/home_page.dart';

void main() {
  runApp(const TrainTicketApp());
}

class TrainTicketApp extends StatelessWidget {
  const TrainTicketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기차 예매',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.grey[200],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
      ),
      home: const HomePage(),
    );
  }
}