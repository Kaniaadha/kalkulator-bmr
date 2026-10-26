import 'package:flutter/material.dart';
import 'pages/input_page.dart';
import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Nama aplikasi yang ditampilkan sistem.
      title: 'BMR Calculator',

      // Menghilangkan banner DEBUG di pojok kanan atas.
      debugShowCheckedModeBanner: false,

      // Mengatur tema visual seluruh aplikasi.
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
          surface: surfaceColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          foregroundColor: headingColor,
          elevation: 0,
          centerTitle: false,
        ),
        fontFamily: 'Roboto',
      ),

      // Halaman pertama yang dibuka.
      home: const InputPage(),
    );
  }
}
