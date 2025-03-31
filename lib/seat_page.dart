// lib/seat_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    Key? key,
    required this.departureStation,
    required this.arrivalStation,
  }) : super(key: key);

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  // 선택된 좌석 관리
  Set<String> selectedSeats = {};
  String? currentSelectedSeat;

  // 좌석 선택 토글
  void _toggleSeat(String seatId) {
    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
        currentSelectedSeat = null;
      } else {
        selectedSeats.clear(); // 기존 선택 해제
        selectedSeats.add(seatId);
        currentSelectedSeat = seatId;
        _showBookingConfirmDialog(seatId);
      }
    });
  }

  // 예매 확인 대화상자
  void _showBookingConfirmDialog(String seatId) {
    // seatId에서 행과 열 추출 (예: "3A"에서 행=3, 열=A)
    String row = seatId.substring(0, seatId.length - 1);
    String col = seatId.substring(seatId.length - 1);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    '예매 하시겠습니까?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text('좌석 : $row-$col'), // 좌석 번호 표시 형식 변경
                ],
              ),
            ),
            const Divider(height: 1),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectedSeats.remove(seatId);
                          currentSelectedSeat = null;
                        });
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('취소', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  const VerticalDivider(width: 1),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('확인', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('좌석 선택'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 상단 출발-도착 정보
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.departureStation,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                  child: const Icon(Icons.arrow_forward, size: 16),
                ),
                const SizedBox(width: 15),
                Text(
                  widget.arrivalStation,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
          
          // 선택 상태 표시
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('선택됨'),
                const SizedBox(width: 40),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('선택안됨'),
              ],
            ),
          ),
          
          // 좌석 레이블 (A, B, C, D)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text('A', style: TextStyle(fontSize: 16)),
                const Text('B', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 20),  // 중앙 공간
                const Text('C', style: TextStyle(fontSize: 16)),
                const Text('D', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          
          // 좌석 리스트 영역
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                itemCount: 10,
                itemBuilder: (context, index) {
                  final rowNumber = index + 1;
                  // 행 번호 5 표시 건너뛰기
                  if (rowNumber == 4 || rowNumber == 5) {
                    return const SizedBox.shrink();
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // A열 좌석
                        _buildSeat('$rowNumber${'A'}'),
                        
                        // B열 좌석
                        _buildSeat('$rowNumber${'B'}'),
                        
                        // 행 번호
                        SizedBox(
                          width: 20,
                          child: Text(
                            '$rowNumber',
                            style: const TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        
                        // C열 좌석
                        _buildSeat('$rowNumber${'C'}'),
                        
                        // D열 좌석
                        _buildSeat('$rowNumber${'D'}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          
          // 예매하기 버튼
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedSeats.isNotEmpty ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  disabledBackgroundColor: Colors.purple.withOpacity(0.6),
                ),
                child: const Text(
                  '예매 하기',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 좌석 위젯 빌더
  Widget _buildSeat(String seatId) {
    final bool isSelected = selectedSeats.contains(seatId);
    
    return GestureDetector(
      onTap: () => _toggleSeat(seatId),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}