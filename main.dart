// lib/main.dart
import 'package:flutter/material.dart';
import 'home_page.dart';  // 상대 경로로 수정

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
      home: const HomePage(),  // HomePage 클래스 사용
    );
  }
}