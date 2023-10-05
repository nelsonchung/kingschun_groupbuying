import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // 這行很重要
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF4CAD73),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: height * 0.15),  // 使用螢幕高度的 5%
            Text(
              'KingsChun購物網',
              style: GoogleFonts.montserratAlternates(
                fontSize: width * 0.10,  // 使用螢幕寬度的 5%
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: height * 0.05),  // 使用螢幕高度的 2%
            /*
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 0,
                  child: Image.asset('assets/man_leftside.png', width: width * 0.4),
                ),
                Positioned(
                  right: 0,
                  child: Image.asset('assets/woman_rightside.png', width: width * 0.2),
                ),
              ],
            ),
            */
//
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Positioned(
                  //left: 150,
                  child: Image.asset('assets/man_leftside.png', width: width * 0.4),
                ),
                Positioned(
                  //right: 150,
                  child: Image.asset('assets/woman_rightside.png', width: width * 0.2),
                ),
              ],
            ),
//            
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset('assets/man_leftside.png', width: width * 0.4),  // 使用螢幕寬度的 20%
                Image.asset('assets/woman_rightside.png', width: width * 0.2),  // 使用螢幕寬度的 20%
              ],
            ),
            */
            SizedBox(height: height * 0.05),  // 使用螢幕高度的 2%
            Padding(
              padding: EdgeInsets.all(height * 0.05),  // 使用螢幕高度的 2%
              child: Text(
                'KingsChun購物網是一個平台\n讓你輕鬆容易地macbook pro, \nmacbook air, ipad, iphone\n二手交易的apps',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserratAlternates(
                  fontSize: width * 0.04,  // 使用螢幕寬度的 4%
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(height * 0.02),  // 使用螢幕高度的 2%
              child: SizedBox(
                width: width * 0.5,  // 使用螢幕寬度的 50%
                height: height * 0.1,  // 使用螢幕高度的 7%
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
                      fontFamily: 'Montserrat Alternates',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
