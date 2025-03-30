import 'package:flutter/material.dart';

class AddQuestionScreen extends StatefulWidget {
  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String? _selectedCategory;
  List<String> _categories = ['Học phí', 'Thời gian học', 'Khác'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm câu hỏi mới"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: const Text("Chọn loại câu hỏi"),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                items:
                    _categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) =>
                    value == null ? 'Vui lòng chọn loại câu hỏi' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: "Tiêu đề",
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontFamily: 'NotoSans'),
                validator: (value) =>
                    value!.isEmpty ? 'Vui lòng nhập tiêu đề' : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: "Nội dung câu hỏi",
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                style: const TextStyle(fontFamily: 'NotoSans'),
                validator: (value) =>
                    value!.isEmpty ? 'Vui lòng nhập nội dung câu hỏi' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle form submission
                    Navigator.pop(context);
                  }
                },
                child: const Text("Gửi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
