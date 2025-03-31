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

class _SeatPageState extends State<SeatPage> with SingleTickerProviderStateMixin {
  // 선택된 좌석 관리
  Set<String> selectedSeats = {};
  TabController? _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  
  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  // 좌석 선택 토글
  void _toggleSeat(String seatId) {
    setState(() {
      if (selectedSeats.contains(seatId)) {
        selectedSeats.remove(seatId);
      } else {
        if (selectedSeats.isEmpty) {
          selectedSeats.add(seatId);
          _showBookingConfirmDialog(seatId);
        } else {
          // 이미 선택된 좌석이 있으면 다른 좌석은 선택 불가
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('한 번에 한 좌석만 선택할 수 있습니다')),
          );
        }
      }
    });
  }

  // 예매 확인 대화상자
  void _showBookingConfirmDialog(String seatId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text('예매 하시겠습니까?'),
        content: Text('${widget.departureStation}에서 ${widget.arrivalStation}까지 1개의 좌석이 예매됩니다.\n좌석: $seatId'),
        actions: [
          TextButton(
            child: const Text('취소'),
            onPressed: () {
              setState(() {
                selectedSeats.remove(seatId);
              });
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('확인'),
            onPressed: () {
              Navigator.pop(context); // 다이얼로그 닫기
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          // 상단 탭바
          Container(
            color: Colors.grey[200],
            child: TabBar(
              controller: _tabController,
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.purple,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.departureStation),  // 출발지 표시
                      const SizedBox(width: 8),
                      Icon(Icons.circle, size: 12, color: Colors.purple),
                    ],
                  ),
                ),
                Tab(text: widget.arrivalStation),  // 도착지 표시
              ],
            ),
          ),
          
          // 좌석 선택 구분 탭
          Container(
            color: Colors.grey[200],
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.purple,
                    child: const Center(
                      child: Text(
                        '선택팁',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text('선택안됨'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 좌석 레이블 (A, B, C, D)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      'A',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      'B',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(width: 40),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      'C',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,
                  child: Center(
                    child: Text(
                      'D',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 좌석 리스트 영역
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: 10,
              itemBuilder: (context, index) {
                final rowNumber = index + 1;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // A열 좌석
                      _buildSeat('${rowNumber}A'),
                      
                      // B열 좌석
                      _buildSeat('${rowNumber}B'),
                      
                      // 행 번호
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        child: Text(
                          '$rowNumber',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                      
                      // C열 좌석
                      _buildSeat('${rowNumber}C'),
                      
                      // D열 좌석
                      _buildSeat('${rowNumber}D'),
                    ],
                  ),
                );
              },
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
                    borderRadius: BorderRadius.circular(8),
                  ),
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
        margin: const EdgeInsets.all(2.0),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}