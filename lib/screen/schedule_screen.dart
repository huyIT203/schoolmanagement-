import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/model/classmodel.dart';
import 'package:flutter_google_sign_in/service/APIservice.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thời khóa biểu",
            style: TextStyle(fontFamily: 'NotoSans')),
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<List<ClassModel>>(
        future: ApiService().fetchallClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Lỗi: ${snapshot.error}",
                  style: TextStyle(fontFamily: 'NotoSans')),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Không có dữ liệu",
                  style: TextStyle(fontFamily: 'NotoSans')),
            );
          } else {
            List<ClassModel> classes = snapshot.data!;
            return ListView.builder(
              itemCount: classes.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      classes[index].subject,
                      style: const TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          "Phòng: ${classes[index].room}",
                          style: const TextStyle(
                              fontFamily: 'NotoSans', fontSize: 16),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          classes[index].schedule,
                          style: const TextStyle(
                              fontFamily: 'NotoSans', fontSize: 16),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ClassDetailScreen(classModel: classes[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ClassDetailScreen extends StatelessWidget {
  final ClassModel classModel;

  const ClassDetailScreen({Key? key, required this.classModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(classModel.subject,
            style: const TextStyle(fontFamily: 'NotoSans')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              classModel.className,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSans',
                  color: Colors.blue),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.book, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  "Môn học: ${classModel.subject}",
                  style: const TextStyle(fontSize: 18, fontFamily: 'NotoSans'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.person, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  "Giáo viên: ${classModel.teacher}",
                  style: const TextStyle(fontSize: 18, fontFamily: 'NotoSans'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.schedule, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  "Lịch học: ${classModel.schedule}",
                  style: const TextStyle(fontSize: 18, fontFamily: 'NotoSans'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.room, color: Colors.purple),
                const SizedBox(width: 8),
                Text(
                  "Phòng: ${classModel.room}",
                  style: const TextStyle(fontSize: 18, fontFamily: 'NotoSans'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
