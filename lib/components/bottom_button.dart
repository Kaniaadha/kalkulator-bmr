import 'package:flutter/material.dart';

import '../constants.dart';

class BottomButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onTap;

  const BottomButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: calculateButtonStyle,
        onPressed: onTap,
        child: Text(
          buttonTitle,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}