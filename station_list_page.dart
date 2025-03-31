// lib/pages/station_list_page.dart
import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final bool isDeparture;
  
  const StationListPage({
    Key? key,
    required this.isDeparture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 기차역 리스트
    final List<String> stations = [
      "수서", "동탄", "평택지제", "천안아산", "오송", 
      "대전", "김천구미", "동대구", "경주", "울산", "부산"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isDeparture ? '출발역' : '도착역'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, stations[index]);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  stations[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}