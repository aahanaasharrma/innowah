import 'package:flutter/material.dart';
import 'package:innowah/aboutus.dart';
import 'package:innowah/car_route.dart';
import 'package:innowah/carbonpage.dart';
import 'package:innowah/eventspage.dart';
import 'package:innowah/getstarted.dart';
import 'package:innowah/profilepage.dart';
import 'package:innowah/rentals_page.dart';
import 'package:innowah/rewards_page.dart';
import 'homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetStarted(),
    );
  }
}
