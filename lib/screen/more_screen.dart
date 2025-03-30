import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/screen/profile_screen.dart';
import 'package:flutter_google_sign_in/service/auth/authservice.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final userStream = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Khác"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder<User?>(
              stream: userStream,
              builder: (context, snapshot) {
                final user = snapshot.data;
                return ListTile(
                  leading: const Icon(Icons.account_circle, size: 50),
                  title: Text(user?.email ?? 'Không có thông tin'),
                  subtitle: const Text("Xem thông tin tài khoản"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
                    );
                  },
                );
              },
            ),
            const Divider(),
            // Add more options here
          ],
        ),
      ),
    );
  }
}
