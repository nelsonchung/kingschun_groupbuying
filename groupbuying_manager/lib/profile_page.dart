import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');

    if (userDataString != null) {
      setState(() {
        userData = jsonDecode(userDataString);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4CAD73), // 背景顏色與 product_list_page.dart 一致
      appBar: AppBar(
        title: Text('個人資料', style: TextStyle(color: Colors.white)), // 字串顏色為白色
        backgroundColor: Color(0xFF4CAD73),  // 背景顏色與 product_list_page.dart 一致
        elevation: 0,
      ),
      body: Container(
        /*
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'), // 使用與 product_list_page.dart 相同的背景圖片
            fit: BoxFit.cover,
          ),
        ),
        */
        child: Center(
          child: userData != null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (userData!['photoUrl'] != null)
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(userData!['photoUrl']),
                      ),
                    SizedBox(height: 16),
                    Text('姓名：${userData!['displayName'] ?? '未提供'}', 
                        style: TextStyle(color: Colors.white)), // 字串顏色為白色
                    SizedBox(height: 8),
                    Text('信箱：${userData!['email'] ?? '未提供'}',
                        style: TextStyle(color: Colors.white)), // 字串顏色為白色
                  ],
                )
              : Text('找不到使用者資料', style: TextStyle(color: Colors.white)), // 字串顏色為白色
        ),
      ),
    );
  }
}
