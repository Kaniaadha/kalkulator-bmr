import 'package:flutter/material.dart';

const Color primaryColor = Color(0xFF52745C);
const Color headingColor = Color(0xFF263C32);
const Color backgroundColor = Color(0xFFF7F7F4);
const Color surfaceColor = Color(0xFFFFFFFF);
const Color textColor = Color(0xFF333B35);
const Color secondaryTextColor = Color(0xFF687268);
const Color borderColor = Color(0xFFD9DDD7);

enum Gender {
  male,
  female,
}

enum BMRFormula {
  mifflinStJeor,
  revisedHarrisBenedict,
  katchMcArdle,
}

const TextStyle headingTextStyle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w700,
  color: headingColor,
);

const TextStyle sectionTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: headingColor,
);

const TextStyle labelTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: textColor,
);

const TextStyle secondaryTextStyle = TextStyle(
  fontSize: 13,
  color: secondaryTextColor,
);

const TextStyle resultNumberStyle = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w700,
  color: headingColor,
);

const InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: surfaceColor,
  contentPadding: EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 13,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: borderColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(color: borderColor),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      color: primaryColor,
      width: 1.5,
    ),
  ),
);

final ButtonStyle calculateButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: primaryColor,
  foregroundColor: Colors.white,
  elevation: 0,
  padding: const EdgeInsets.symmetric(
    horizontal: 24,
    vertical: 15,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5),
  ),
);