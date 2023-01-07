//TODO: Create a model to store the settings of the app per each user
//TODO: Create a settings provider for getting the settings of the app per user
//TODO: Create settings page for the user to change the settings


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserThemeData{
  late final String? UID;
  late final int AppbarbackColor;
  late final int AppbariconColor;
  late final int AppbartextColor;
  late final int AppbartextbuttonColor;
  late final int AppbarShadowColor;
  late final int ScaffoldbackColor;
  late final int ScaffoldtextColor;
  late final int ScaffoldiconColor;
  late final int ScaffoldbuttonColor;
  late final int ScaffoldbuttonTextColor;
  late final int ScaffoldbuttonIconColor;
  late final int ScaffoldbuttonborderColor;
  late final int CardBackgroundColor;
  late final int CardTextColor;
  late final int CardBorderColor;
  late final int CardShadowColor;
  late final int CardIconColor;
  late final int BottomNavBackColor;
  late final int BottomNavTextColor;
  late final int BottomNavIconColor;
  late final bool DarkMode;

  UserThemeData({
   this.UID,
    this.AppbarbackColor=0xFF000000,
    this.AppbarShadowColor=0xFF000000,
    this.AppbariconColor=0xFFFFFFFF,
    this.AppbartextColor=0xFFFFFFFF,
    this.AppbartextbuttonColor=0xFF2196F3,
    this.ScaffoldbackColor=0xFF000000,
    this.ScaffoldtextColor=0xFFFFFFFF,
    this.ScaffoldiconColor=0xFFFFFFFF,
    this.ScaffoldbuttonColor=0xFF40C4FF,
    this.ScaffoldbuttonTextColor=0xFFFFFFFF,
    this.ScaffoldbuttonIconColor=0xFFFFFFFF,
    this.ScaffoldbuttonborderColor=0xFFFFFFFF,
    this.CardBackgroundColor=0xFF000000,
    this.CardTextColor=0xFFFFFFFF,
    this.CardBorderColor=0xFF000000,
    this.CardShadowColor=0xFF000000,
    this.CardIconColor=0xFFFFFFFF,
    this.BottomNavBackColor=0xFF000000,
    this.BottomNavTextColor=0xFFFFFFFF,
    this.BottomNavIconColor=0xFFFFFFFF,
    this.DarkMode=true
  });

  Map<String,dynamic> toJson()=>{
    "uid":UID,
    "AppbarbackColor":AppbarbackColor,
    "AppbarShadowColor":AppbarShadowColor,
    "AppbariconColor":AppbariconColor,
    "AppbartextColor":AppbartextColor,
    "AppbartextbuttonColor":AppbartextbuttonColor,
    "ScaffoldbackColor":ScaffoldbackColor,
    "ScaffoldtextColor":ScaffoldtextColor,
    "ScaffoldiconColor":ScaffoldiconColor,
    "ScaffoldbuttonColor":ScaffoldbuttonColor,
    "ScaffoldbuttonTextColor":ScaffoldbuttonTextColor,
    "ScaffoldbuttonIconColor":ScaffoldbuttonIconColor,
    "ScaffoldbuttonborderColor":ScaffoldbuttonborderColor,
    "CardBackgroundColor":CardBackgroundColor,
    "CardTextColor":CardTextColor,
    "CardBorderColor":CardBorderColor,
    "CardShadowColor":CardShadowColor,
    "CardIconColor":CardIconColor,
    "BottomNavBackColor":BottomNavBackColor,
    "BottomNavTextColor":BottomNavTextColor,
    "BottomNavIconColor":BottomNavIconColor,
    "DarkMode":DarkMode
  
  };

  static UserThemeData FromSnap(DocumentSnapshot snap){
    var snapshot= snap.data() as Map<String,dynamic>;
    UserThemeData Theme=UserThemeData(
      UID:snapshot["uid"],
      AppbarbackColor:snapshot["AppbarbackColor"],
      AppbarShadowColor:snapshot["AppbarShadowColor"],
      AppbariconColor:snapshot["AppbariconColor"],
      AppbartextColor:snapshot["AppbartextColor"],
      AppbartextbuttonColor: snapshot["AppbartextbuttonColor"],
      ScaffoldbackColor:snapshot["ScaffoldbackColor"],
      ScaffoldtextColor:snapshot["ScaffoldtextColor"],
      ScaffoldiconColor:snapshot["ScaffoldiconColor"],
      ScaffoldbuttonColor:snapshot["ScaffoldbuttonColor"],
      ScaffoldbuttonTextColor:snapshot["ScaffoldbuttonTextColor"],
      ScaffoldbuttonIconColor:snapshot["ScaffoldbuttonIconColor"],
      ScaffoldbuttonborderColor:snapshot["ScaffoldbuttonborderColor"],
      CardBackgroundColor:snapshot["CardBackgroundColor"],
      CardTextColor:snapshot["CardTextColor"],
      CardBorderColor:snapshot["CardBorderColor"],
      CardShadowColor:snapshot["CardShadowColor"],
      CardIconColor:snapshot["CardIconColor"],
      BottomNavBackColor:snapshot["BottomNavBackColor"],
      BottomNavTextColor:snapshot["BottomNavTextColor"],
      BottomNavIconColor:snapshot["BottomNavIconColor"],
      DarkMode:snapshot["DarkMode"]

    );
    return Theme;
  }
  






}