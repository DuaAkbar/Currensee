import 'package:flutter/material.dart';

final ThemeData mytheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme:  ColorScheme.light(
    brightness: Brightness.light,
    surface: Color(0xFFFFF0F5), 
    onSurface: Color(0xFFD81B60),   
    surfaceTint: Color(0xFFFAD1E8), 
    primary: Color(0xFFD81B60),     
    onPrimary: Colors.white,        
    secondary: Color(0xFFFAD1E8),   
  ),

  appBarTheme:  AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    surfaceTintColor: Color(0xFFD81B60),
  ),
  
  navigationBarTheme:  NavigationBarThemeData(
    backgroundColor: Colors.transparent,
    elevation: 0,
    indicatorColor: Color(0xFFFAD1E8,), 
    iconTheme: WidgetStatePropertyAll(
      IconThemeData(
        color: Color(0xFFD81B60), 
        size: 30,
      ),
    ),
  ),
);
