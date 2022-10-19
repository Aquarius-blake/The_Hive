import 'dart:ui';

import 'package:flutter/material.dart';

class MSettings extends StatefulWidget {
  const MSettings({ Key? key }) : super(key: key);

  @override
  State<MSettings> createState() => _MSettingsState();
}

class _MSettingsState extends State<MSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text('Settings'),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),    
        actions: [
          TextButton(
            onPressed: (){},
             child: Text(
              "Save",
              style: TextStyle(),
              )
             )
        ], 
      ),
    );
  }
}