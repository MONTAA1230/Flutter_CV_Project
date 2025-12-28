import 'package:flutter/material.dart';

// Global theme notifier for the whole app
ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
bool get isDarkMode => themeNotifier.value == ThemeMode.dark;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
