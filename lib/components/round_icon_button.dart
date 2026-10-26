
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Widget tombol berbentuk lingkaran.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  // Ikon menggunakan tipe data Font Awesome.
  final FaIconData icon;

  // Fungsi yang dipanggil saat tombol ditekan.
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      constraints: const BoxConstraints.tightFor(
        width: 40.0,
        height: 40.0,
      ),
      shape: const CircleBorder(),
      fillColor: const Color(0xFF4C4F5E),
      onPressed: onPressed,
      child: FaIcon(icon),
    );
  }
}
