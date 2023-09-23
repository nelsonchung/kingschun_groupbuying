/*
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * Author: Nelson Chung
 * Creation Date: August 28, 2023
 */
 
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // 這行很重要
  await Firebase.initializeApp();
  runApp(MyApp());
}
/*
void main() => runApp(MyApp());
*/
/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google 登入示例',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: LoginPage(), // 使用您提供的 LoginGooglePage 作為主頁面
      home: MainPage(),
    );
  }
}
*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KingsChun購物網',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4CAD73),
      body: Stack(
        children: <Widget>[
          // Background up image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/background-up.png', fit: BoxFit.cover),
          ),
          /*
          Positioned(
            top: 300,
            left: 50,
            child: Container(
              child: Image.asset('assets/shadow.png'),
              //color: Colors.red,
              width: 125.17,
              height: 14.64,
            ),
          ),
          Positioned(
            top: 300,
            left: 176,
            child: Container(
              child: Image.asset('assets/shadow.png'),
              //color: Colors.red,
              width: 125.17,
              height: 14.64,
            ),
          ),
          */
          Positioned(
            top: 55,
            left: 75,
            child: Text(
              'KingsChun購物網',
              style: GoogleFonts.montserratAlternates(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ), 
          ),         
          Positioned(
            top: 100,
            left: 20,
            child: Container(
              child: Image.asset('assets/man_leftside.png'),
              width: 225.57,
              height: 236.52,
            ),
          ),
          Positioned(
            top: 100,
            left: 190,
            child: Container(
              child: Image.asset('assets/woman_rightside.png'),
              width: 108.66,
              height: 237.30,
            ),
          ),
          Positioned(
            top: 360,
            left: 45,
            child: Text(
              'KingsChun購物網是一個平台\n讓你容易地macbook pro, \nmacbook air, ipad, iphone\n二手交易的apps',
              style: GoogleFonts.montserratAlternates(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ), 
          ),
          Positioned(
            top: 480,  // 距離底部20像素
            left: 35,  // 距離左邊20像素
            child: Container(
              width: 250,  // 按鈕的寬度
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text(
                  '開始使用',
                  style: TextStyle(
                    color: Color(0xFF4CAD73),
                    fontFamily: 'Montserrat Alternates',  // 使用Google Fonts指定的字體
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,  // 背景色
                  onPrimary: Color(0xFF4CAD73),  // 字體和icon的顏色
                ),
              ),
            ),
          ),          
          /*
          // Background down image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset('assets/shadow.png', fit: BoxFit.cover),
          ),*/
        ],
      ),
    );
  }
}

