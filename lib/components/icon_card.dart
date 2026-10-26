
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../constants.dart';

// Widget untuk menampilkan ikon dan keterangan.
class IconCard extends StatelessWidget {
  const IconCard({
    super.key,
    required this.cardIcon,
    required this.caption,
  });

  // Menggunakan FaIconData agar kompatibel dengan Font Awesome.
  final FaIconData cardIcon;

  // Teks keterangan di bawah ikon.
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          cardIcon,
          size: 60.0,
        ),
        const SizedBox(height: 12.0),
        Text(
          caption,
          style: labelTextStyle,
        ),
      ],
    );
  }
}
