import 'package:currency_converter/app/models/currency_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class AppController extends ChangeNotifier{
  
  static AppController instance = AppController();

  LocalStorage storage = new LocalStorage('data');

  late bool cached;
  late bool loaded = false;

  List<CurrencyModel> currencies = [];

  bool darkTheme = false;

  toggleDarkTheme(){
    darkTheme = !darkTheme;
    notifyListeners();
  }

}