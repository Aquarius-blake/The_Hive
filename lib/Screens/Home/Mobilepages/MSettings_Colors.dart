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
      backgroundColor: Color(themedata.ScaffoldbackColor),
      appBar: AppBar(
        elevation:0.00,
        backgroundColor: Color(themedata.AppbarbackColor),
        centerTitle: true,
        title: Text(
          "Customize theme",
          style: TextStyle(
            color: Color(themedata.AppbartextColor)
          ),
          ),
          actions: [
            TextButton(
              onPressed: (){},
              child: Text(
                "Save changes",
                style: TextStyle(
                  color: Color(themedata.AppbartextbuttonColor!),
                  fontSize: 12, 
                )
                )
              )
          ],
          //body
      ),
    );
  }
}