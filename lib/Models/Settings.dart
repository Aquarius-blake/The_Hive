//TODO: Create a model to store the settings of the app per each user
//TODO: Create a settings provider for getting the settings of the app per user
//TODO: Create settings page for the user to change the settings


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserThemeData{
  late final String? UID;
  late final Color? AppbarbackColor;
  late final Color AppbariconColor;
  late final Color AppbartextColor;
  late final Color AppbarShadowColor;
  late final Color ScaffoldbackColor;
  late final Color ScaffoldtextColor;
  late final Color ScaffoldiconColor;
  late final Color ScaffoldbuttonColor;
  late final Color ScaffoldbuttonTextColor;
  late final Color ScaffoldbuttonIconColor;
  late final Color ScaffoldbuttonborderColor;
  late final Color CardBackgroundColor;
  late final Color CardTextColor;
  late final Color CardBorderColor;
  late final Color CardShadowColor;
  late final Color CardIconColor;
  late final Color BottomNavBackColor;
  late final Color BottomNavTextColor;
  late final Color BottomNavIconColor;

  UserThemeData({
   this.UID,
    this.AppbarbackColor=Colors.black,
    this.AppbarShadowColor=Colors.black,
    this.AppbariconColor=Colors.white,
    this.AppbartextColor=Colors.white,
    this.ScaffoldbackColor=Colors.black,
    this.ScaffoldtextColor=Colors.white,
    this.ScaffoldiconColor=Colors.white,
    this.ScaffoldbuttonColor=Colors.lightBlueAccent,
    this.ScaffoldbuttonTextColor=Colors.white,
    this.ScaffoldbuttonIconColor=Colors.white,
    this.ScaffoldbuttonborderColor=Colors.white,
    this.CardBackgroundColor=Colors.black,
    this.CardTextColor=Colors.white,
    this.CardBorderColor=Colors.black,
    this.CardShadowColor=Colors.black,
    this.CardIconColor=Colors.white,
    this.BottomNavBackColor=Colors.black,
    this.BottomNavTextColor=Colors.white,
    this.BottomNavIconColor=Colors.white,
  });

  Map<String,dynamic> toJson()=>{};
  
}