import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KingsChun購物網',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: KangsayurLayout(),
    );
  }
}

class KangsayurLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4CAD73),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Text(
                    'KingsChun購物網',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/man_leftside.png'),
                      SizedBox(width: 20.0),
                      Image.asset('assets/woman_rightside.png'),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'KingsChun購物網是一個平台\n讓你輕鬆容易地macbook pro, \nmacbook air, ipad, iphone\n二手交易的apps',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
              child: ElevatedButton(
                onPressed: () {
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  */
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
          ],
        ),
      ),
    );
  }
}
