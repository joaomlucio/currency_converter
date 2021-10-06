import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class AppController extends ChangeNotifier{
  
  static AppController instance = AppController();
  LocalStorage storage = new LocalStorage('data');

  bool darkTheme = true;

  toggleDarkTheme(){
    darkTheme = !darkTheme;
    notifyListeners();
  }

}