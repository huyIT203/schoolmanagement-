import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final TextEditingController _codeController = TextEditingController();
  String? generatedCode;
  int expirationTime = 0; // Mốc thời gian hết hạn mã điểm danh
  String statusMessage = '';

  // Khởi tạo mã điểm danh
  Future<void> generateAttendanceCode() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/attendance/generateCode'),
    );
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        generatedCode = responseData['code'];
        expirationTime = responseData['expirationTime'];
        statusMessage = 'Mã điểm danh đã được tạo: $generatedCode';
      });
      // Hết hạn mã sau 30 giây
      Timer(Duration(seconds: 30), () {
        setState(() {
          statusMessage = 'Mã điểm danh hết hạn';
        });
      });
    } else {
      setState(() {
        statusMessage = 'Lỗi khi tạo mã điểm danh';
      });
    }
  }

  // Kiểm tra mã điểm danh nhập vào
  Future<void> validateAttendanceCode() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/attendance/validateCode'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'code': _codeController.text}),
    );
    if (response.statusCode == 200) {
      setState(() {
        statusMessage = 'Điểm danh thành công';
      });
    } else {
      setState(() {
        statusMessage = 'Mã điểm danh không hợp lệ hoặc hết thời gian';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    generateAttendanceCode(); // Tạo mã điểm danh ngay khi vào trang
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Điểm danh")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              statusMessage,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: "Nhập mã điểm danh",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: validateAttendanceCode,
              child: const Text("Xác nhận"),
            ),
          ],
        ),
      ),
    );
  }
}
