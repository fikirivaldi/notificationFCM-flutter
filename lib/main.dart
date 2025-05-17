import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notification_app/firebase_options.dart';
import 'package:notification_app/screens/notification_screen.dart';
import 'package:notification_app/service/fcm_service.dart';
import 'package:notification_app/service/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //ns
  final NotificationService ns = NotificationService();
  await ns.init();

  //fcm
  final FcmService fcmService = FcmService();
  await fcmService.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: NotificationScreen(),
    );
  }
}
