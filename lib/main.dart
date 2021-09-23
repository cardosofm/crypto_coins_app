import 'package:criptocoin/coins_page.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(CoinApp());
}

class CoinApp extends StatelessWidget {
  const CoinApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Coin App",
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Coins_Page(),
    );
  }
}
