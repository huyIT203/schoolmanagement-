import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/service/auth/authservice.dart';
import 'package:flutter_google_sign_in/screen/loginscreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final userStream = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông tin tài khoản"),
        backgroundColor: Colors.teal,
        // Remove this line or set it to true
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Thông tin tài khoản",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal),
            ),
            const SizedBox(height: 20),
            StreamBuilder<User?>(
              stream: userStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text("Error loading user data",
                      style: TextStyle(color: Colors.red));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return const Text("Không có thông tin",
                      style: TextStyle(color: Colors.grey));
                } else {
                  return Text(
                    "Email: ${snapshot.data!.email}",
                    style: const TextStyle(fontSize: 18, color: Colors.black87),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await auth.signout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text("Đăng xuất"),
            ),
          ],
        ),
      ),
    );
  }
}
