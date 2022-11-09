import 'package:flutter/material.dart';

class CustomThemePage extends StatefulWidget {
  const CustomThemePage({ Key? key }) : super(key: key);

  @override
  State<CustomThemePage> createState() => _CustomThemePageState();
}

class _CustomThemePageState extends State<CustomThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}