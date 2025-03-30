import 'package:flutter/material.dart';
import 'add_question_screen.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Hỏi đáp"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddQuestionScreen()),
                );
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Câu hỏi đã gửi"),
              Tab(text: "Câu hỏi quan tâm nhiều"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SentQuestionsScreen(),
            PopularQuestionsScreen(),
          ],
        ),
      ),
    );
  }
}

class SentQuestionsScreen extends StatelessWidget {
  const SentQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          ListTile(
            title: Text("Câu hỏi 1"),
            subtitle: Text("Nội dung câu hỏi 1."),
          ),
          ListTile(
            title: Text("Câu hỏi 2"),
            subtitle: Text("Nội dung câu hỏi 2."),
          ),
          // Add more sent questions here
        ],
      ),
    );
  }
}

class PopularQuestionsScreen extends StatelessWidget {
  const PopularQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: const [
          ListTile(
            title: Text("Câu hỏi 3"),
            subtitle: Text("Nội dung câu hỏi 3."),
          ),
          ListTile(
            title: Text("Câu hỏi 4"),
            subtitle: Text("Nội dung câu hỏi 4."),
          ),
          // Add more popular questions here
        ],
      ),
    );
  }
}
