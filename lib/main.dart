import 'package:api_listview/pages/index.dart';
import 'package:api_listview/theme/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: primaryColor,
    ),
    home: IndexPage(),
  ));
}
