import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        hintColor: Colors.white,
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.chewy(fontSize: 28),
          backgroundColor: const Color.fromARGB(255, 204, 41, 90),
        ),
      ),
      //HomePage = todo_list.dart
      home: const HomePage(),
    );
  }
}
