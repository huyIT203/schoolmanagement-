import 'package:flutter/material.dart';
import 'package:flutter_google_sign_in/screen/loginscreen.dart';
import 'package:flutter_google_sign_in/service/auth/authservice.dart';
import 'package:flutter_google_sign_in/widgets/buttons.dart';
import 'attendance_screen.dart';
import 'schedule_screen.dart';
import 'exam_schedule_screen.dart';
import 'package:flutter_google_sign_in/screen/news_screen.dart';
import 'package:flutter_google_sign_in/service/News_Api_Service.dart';
import 'package:flutter_google_sign_in/model/NewsModel.dart';
import 'news_detail_screen.dart';
import 'profile_screen.dart';
import 'faq_screen.dart';
import 'more_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeContent(),
    ScheduleScreen(),
    ExamScheduleScreen(),
    NewsScreen(),
    FAQScreen(),
    MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _refresh() async {
    await NewsApiService().fetchNews();
    setState(() {
      _widgetOptions[_selectedIndex] = _widgetOptions[_selectedIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giáo xứ Hạnh Thông Tây"),
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'TKB',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Lịch thi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Tin tức',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Hỏi đáp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'Khác',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Xin chào bạn!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Truy cập nhanh.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              physics: NeverScrollableScrollPhysics(),
              children: [
                _buildFeatureButton(context, "Điểm danh", Icons.qr_code_scanner,
                    AttendanceScreen()),
                _buildFeatureButton(context, "Thời khóa biểu",
                    Icons.calendar_today, ScheduleScreen()),
                _buildFeatureButton(
                    context, "Lịch thi", Icons.event, ExamScheduleScreen()),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewsScreen())),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Tin tức mới nhất",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.arrow_forward, color: Colors.blue),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            FutureBuilder<List<NewsModel>>(
              future: NewsApiService().fetchNews(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Lỗi: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: const Text('Không có tin tức'));
                } else {
                  List<NewsModel> newsList = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      final newsItem = newsList[index];
                      String previewContent =
                          newsItem.content.split(' ').take(12).join(' ') +
                              '...';
                      return Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    NewsDetailScreen(newsItem: newsItem),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(
                                newsItem.imageUrl,
                                fit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      newsItem.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.blueAccent,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'By ${newsItem.author} on ${newsItem.publishedDate}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      previewContent,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // 🛠 Widget tạo nút chức năng
  Widget _buildFeatureButton(
      BuildContext context, String label, IconData icon, Widget screen) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => screen)),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            const SizedBox(height: 8),
            Text(label,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
