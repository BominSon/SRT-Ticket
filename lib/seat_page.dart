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
    
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('예매 하시겠습니까?'),
        content: Text('좌석 : $row-$col'), // 좌석 표시 형식 변경
        actions: [
          CupertinoDialogAction(
              isDestructiveAction: true, // 취소 버튼을 빨간색으로
            child: const Text('취소'),
            onPressed: () {
              setState(() {
                selectedSeats.remove(seatId);
                currentSelectedSeat = null;
              });
              Navigator.pop(context); //  Dialog 제거
            },
          ),
          CupertinoDialogAction(
              isDefaultAction: true, // 확인 버튼을 강조
            child: const Text('확인'), // 확인 버튼 파란색으로 표시
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // SeatPage 닫기
              Navigator.pop(context);  // HomePage로 이동(뒤로가기 두번)
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        // ❶ [앱바 타이틀] 별도의 스타일 지정 X - 중앙 정렬만 지정
        title: const Text('좌석 선택'),
        centerTitle: true,
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
                // ❷ [출발역] 글자 두께: FontWeight.bold 글자 색상: Colors.purple 글자 크기: 30
                Text(
                  widget.departureStation,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                
                // ❹ [화살표 아이콘] 아이콘 데이터: Icons.arrow_circle_right_outlined 아이콘 크기: 30
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 30,
                  ),
                ),
                
                // ❸ [도착역] 글자 두께: FontWeight.bold 글자 색상: Colors.purple 글자 크기: 30
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
          
          // ❺ 좌석 상태 안내
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 선택됨 상태 박스
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4), // 간격 4
                const Text('선택됨'), // 별도 스타일 지정 X
                
                const SizedBox(width: 20), // 선택됨, 선택안됨 간격 20
                
                // 선택안됨 상태 박스
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 4), // 간격 4
                const Text('선택안됨'), // 별도 스타일 지정 X
              ],
            ),
          ),
          
          // ❻❼ ABCD 레이블 및 좌석 리스트 영역
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // ABCD 레이블 표시 (fontSize 18)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
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
                  ),
                  
                  // ❿ 좌석 리스트뷰 영역
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      itemCount: 20, // 총 20개의 행
                      itemBuilder: (context, index) {
                        final rowNumber = index + 1;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0), // 세로 간격 8
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // 내용 가운데 정렬
                            children: [
                              // A열 좌석
                              _buildSeat('${rowNumber}A'),
                              
                              const SizedBox(width: 4), // 가로 간격 4
                              
                              // B열 좌석
                              _buildSeat('${rowNumber}B'),
                              
                              // 행 번호
                              Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  '$rowNumber',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              
                              // C열 좌석
                              _buildSeat('${rowNumber}C'),
                              
                              const SizedBox(width: 4), // 가로 간격 4
                              
                              // D열 좌석
                              _buildSeat('${rowNumber}D'),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // ❾ 예매하기 버튼
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: selectedSeats.isNotEmpty ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple, // 버튼 색상: Colors.purple
                  foregroundColor: Colors.white, // 글자 색상: Colors.white
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // 모서리 둥글기: 20
                  ),
                ),
                child: const Text(
                  '예매 하기',
                  style: TextStyle(
                    fontSize: 18, // 글자 크기: 18
                    fontWeight: FontWeight.bold, // 글자 두께: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ❽ 좌석 위젯 빌더
  Widget _buildSeat(String seatId) {
    final bool isSelected = selectedSeats.contains(seatId);
    
    return GestureDetector( // 좌석 선택을 위한 GestureDetector 추가
      onTap: () => _toggleSeat(seatId), // 터치 시 좌석 선택 토글 함수 호출
      child: Container(
        width: 50, // 너비: 50
        height: 50, // 높이: 50
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300], // 색상: 선택됨 - Colors.purple, 선택안됨 - Colors.grey[300]
          borderRadius: BorderRadius.circular(8), // 모서리 둥글기: 8
        ),
      ),
    );
  }
}