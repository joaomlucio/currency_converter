import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';

class AppController{
  
  static AppController instance = AppController();

  LocalStorage storage = new LocalStorage('data');

  late bool cached;

  ValueNotifier<bool> darkTheme = ValueNotifier<bool>(false);


  Future toggleDarkTheme() async {
    darkTheme.value = !darkTheme.value;
    await storage.setItem('dark', !darkTheme.value);
  }

}