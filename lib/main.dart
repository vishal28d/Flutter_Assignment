import 'package:flutter/material.dart';
import 'package:my_travaly/Pages/login_page.dart';
 

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyTravaly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(

          border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),

          ),
        ),
      ),

      home: const GoogleSignInScreen(),

    );
  }
}
