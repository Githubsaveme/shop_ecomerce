import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_ecomerce/UI/homeScreen/homeScreen.dart';

final Future<SharedPreferences> sharedPreferences =
    SharedPreferences.getInstance();

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}
