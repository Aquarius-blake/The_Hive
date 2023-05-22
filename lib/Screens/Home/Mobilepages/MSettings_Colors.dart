import 'package:flutter/material.dart';
import 'package:forum3/Models/Settings.dart';
import 'package:provider/provider.dart';
import 'package:forum3/Provider/Settings_provider.dart';

class CustomThemePage extends StatefulWidget {
  const CustomThemePage({ Key? key }) : super(key: key);

  @override
  State<CustomThemePage> createState() => _CustomThemePageState();
}

class _CustomThemePageState extends State<CustomThemePage> {

  UserThemeData theme=UserThemeData();

  @override
  Widget build(BuildContext context) {
    late  UserThemeData themedata= Provider.of<ThemeProvider>(context).getUserThemeData;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation:0.00,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Customize the theme",
          style: TextStyle(
            color: Colors.white
          ),
          ),
          actions: [
            TextButton(
              onPressed: (){},
              child: Text(
                "Save changes"
                )
              )
          ],
      ),
    );
  }
}