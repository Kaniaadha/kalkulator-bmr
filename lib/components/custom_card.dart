
import 'package:flutter/material.dart';

// Widget kartu yang dapat menerima warna dan isi berbeda.
class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.color,
    this.cardChild,
    this.onPress,
  });

  // Warna latar belakang kartu.
  final Color color;

  // Widget yang ditampilkan di dalam kartu.
  final Widget? cardChild;

  // Fungsi yang dijalankan saat kartu ditekan.
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: cardChild,
      ),
    );
  }
}
