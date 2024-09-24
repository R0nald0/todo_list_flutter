import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext{
   Color get primaryColor => Theme.of(this).primaryColor;
   Color get primaryColorLight => Theme.of(this).primaryColorLight;
   Color get buttonColor => Theme.of(this).colorScheme.onSecondary;
   TextTheme get textTheme => Theme.of(this).textTheme;

    TextStyle get textstyle => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold ,
    color: Colors.grey
   );

}