import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: KangsayurLayout(),
    );
  }
}

class KangsayurLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('path_to_woman_with_groceries_image'),
                      SizedBox(width: 20.0),
                      Image.asset('path_to_man_with_vegetable_image'),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Kangsayur is a solution for Grocery\nShopping every you need',
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
                  // Handle button press here
                },
                child: Text('Get Started'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
