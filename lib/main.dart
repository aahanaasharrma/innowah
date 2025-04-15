import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:innowah/getstarted.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("🔔 Background Message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Error loading .env file: $e");
  }
  print(dotenv.env['GOOGLE_MAPS_API_KEY']);

  await Firebase.initializeApp();

  // Setup background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setupFCM();
  }

  void _setupFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission for iOS (optional)
    NotificationSettings settings = await messaging.requestPermission();
    print('🔐 Notification permission status: ${settings.authorizationStatus}');

    // Get the device token
    String? token = await messaging.getToken();
    print('📱 FCM Token: $token');

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📩 Foreground Message Received: ${message.notification?.title}');
      if (message.notification != null) {
        // Handle or show a snackbar/notification UI
      }
    });

    // Handle when app is opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print('🚀 App opened via notification: ${message.messageId}');
      }
    });

    // Handle when app is opened from background state
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📲 App opened from background message: ${message.messageId}');
    });
  }

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
