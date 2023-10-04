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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Text(
                    'Kangsayur',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Positioned(
                        left: 150,
                        child: Image.asset('assets/man_leftside.png'/*, width: width * 0.4*/),
                      ),
                      Positioned(
                        right: 150,
                        child: Image.asset('assets/woman_rightside.png'/*, width: width * 0.2*/),
                      ),
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
