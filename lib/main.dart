import 'package:flutter/material.dart';
import 'package:healthconnect/partner/partnermain.dart';
import 'package:healthconnect/user/usermain.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'healthcare Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HealthcareApp(),
    );
  }
}
