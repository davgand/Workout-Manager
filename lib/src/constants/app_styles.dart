import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle dayListStyle = TextStyle(
      fontSize: 25, fontWeight: FontWeight.w400, color: Palette.textColor);

  static const TextStyle exerciseTitleStyle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.w500, color: Palette.textColor);

  static const TextStyle dataStyle = TextStyle(color: Palette.textColor);

  static const TextStyle smallStyle =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w300);

  static const TextStyle boldStyle =
      TextStyle(fontSize: 16, fontWeight: FontWeight.w500);

  static const TextStyle workoutTypeStyle = TextStyle(
    fontSize: 35,
    color: Palette.white,
    fontWeight: FontWeight.normal,
  );

  static const ShapeBorder floatButtonShape = CircleBorder();
}

class Palette {
  static const Color blue = Colors.blue;
  static const Color darkBlue = Color.fromARGB(255, 28, 124, 202);
  static const Color textColor = Color.fromARGB(255, 16, 68, 110);
  static const Color lightBlue = Color.fromARGB(255, 100, 181, 247);
  static const Color white = Color.fromARGB(250, 250, 250, 250);
  static const Color grey = Colors.grey;
  static const Color red = Color(0xFFFE4A49);
}
