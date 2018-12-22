import 'package:flutter/material.dart';
import 'package:your_shop/main_page.dart';

void main() => runApp(YourShop());

class YourShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Your shop",
      theme: ThemeData(
        primarySwatch: Colors.deepOrange
      ),
      home: MainPage(),
    );
  }
}
