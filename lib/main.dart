import 'package:app/helper/database_helper.dart';
import 'package:app/pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'pages/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// Initialize SQLite database
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'loginPage': (context) => loginPage(),
        'SignupPage': (context) => SignupPage(),
      },
      initialRoute: 'loginPage',
      debugShowCheckedModeBanner: false,
    );
  }
}
