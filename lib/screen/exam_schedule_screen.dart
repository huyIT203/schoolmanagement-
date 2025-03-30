import 'package:flutter/material.dart';

class ExamScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lịch thi")),
      body: Center(
        child: Text("Lịch thi chưa có. Vui lòng kiểm tra lại sau!"),
      ),
    );
  }
}
