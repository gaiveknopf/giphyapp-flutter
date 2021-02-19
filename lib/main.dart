import 'package:flutter/material.dart';
import 'package:giphyapp/ui/home_page.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('#ffffff'))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: HexColor('#ffffff'))),
        hintStyle: TextStyle(color: HexColor('#28262e')),
      ),
    ),
  ));
}
