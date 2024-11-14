import 'package:flutter/material.dart';
import 'package:zaki_mobile/splashscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zaki Mobile',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueAccent,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.blueAccent,
        ),
      ),
      home: SplashScreen(), // Menampilkan SplashScreen pertama kali
    );
  }
}
