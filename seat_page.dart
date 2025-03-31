// lib/pages/seat_page.dart
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

  // 좌석 선택 토글
  void _toggleSeat(String seatId) {
    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
      } else {
        selectedSeats.add(seatId);
      }
    });
  }

  // 예매 완료 대화상자
  void _showBookingConfirmDialog() {
    if (selectedSeats.isEmpty) {
      return; // 선택된 좌석이 없으면 아무것도 하지 않음
    }

    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('예매 하시겠습니까?'),
        content: Text('${widget.departureStation}에서 ${widget.arrivalStation}까지 ${selectedSeats.length}개의 좌석이 예매됩니다.'),
        actions: [
          CupertinoDialogAction(
            child: const Text('취소'),
            onPressed: () {
              Navigator.pop(context); // 대화상자 닫기
            },
          ),
          CupertinoDialogAction(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context); // 대화상자 닫기
              Navigator.pop(context); // SeatPage 닫기
              Navigator.pop(context); // HomePage로 돌아가기
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('좌석 선택'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 상단 정보 표시
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.departureStation,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 30,
                  ),
                ),
                Text(
                  widget.arrivalStation,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
              ],
            ),
          ),
          
          // 좌석 상태 안내
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('선택됨'),
                
                const SizedBox(width: 20),
                
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4),
                const Text('선택안됨'),
              ],
            ),
          ),
          
          const SizedBox(height: 10),
          
          // 좌석 리스트 영역
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              children: [
                // 좌석 레이블 (A, B, C, D)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'A',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'B',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        ' ',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'C',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        'D',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                
                // 20개의 좌석 행
                for (int row = 1; row <= 20; row++)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // A열 좌석
                        _buildSeat('${row}A'),
                        
                        // B열 좌석
                        _buildSeat('${row}B'),
                        
                        // 행 번호
                        Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          child: Text(
                            '$row',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                        
                        // C열 좌석
                        _buildSeat('${row}C'),
                        
                        // D열 좌석
                        _buildSeat('${row}D'),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          // 예매하기 버튼
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedSeats.isNotEmpty ? _showBookingConfirmDialog : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
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
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0),
      child: InkWell(
        onTap: () => _toggleSeat(seatId),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: isSelected ? Colors.purple : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}