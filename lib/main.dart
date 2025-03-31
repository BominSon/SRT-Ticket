// lib/main.dart
import 'package:flutter/material.dart';
import 'home_page.dart'; // 이 임포트는 필요합니다

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
      home: const HomePage(), // 여기에서 HomePage 클래스를 사용합니다
    );
  }
}
