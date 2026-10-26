import 'package:flutter/material.dart';
import 'pages/input_page.dart';
import 'constants.dart';

// === ALUR PROGRAM (gambaran umum) ===
// 1. main()            -> titik awal; menjalankan aplikasi lewat runApp().
// 2. MyApp             -> mengatur tema dan menetapkan InputPage sebagai halaman pertama.
// 3. InputPage         -> pengguna mengisi data (gender, umur, tinggi, berat, rumus, satuan),
//                         lalu menekan tombol 'Calculate BMR'.
// 4. BMRCalculator     -> (calculator.dart) menghitung BMR sesuai rumus yang dipilih.
// 5. ResultPage        -> menampilkan BMR dan kebutuhan kalori harian per tingkat aktivitas.
// Tombol 'Back to Calculator' mengembalikan pengguna ke InputPage.
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