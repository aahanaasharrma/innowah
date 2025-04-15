import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:innowah/getstarted.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Error loading .env file: $e");
  }
  print(dotenv.env['GOOGLE_MAPS_API_KEY']);

  // Initialize Firebase
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Innowah',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetStarted(),

    );
  }
}
