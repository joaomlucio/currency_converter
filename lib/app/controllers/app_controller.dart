import 'package:currency_converter/app/models/currency_model.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';

class AppController extends ChangeNotifier{
  
  static AppController instance = AppController();

  LocalStorage storage = new LocalStorage('data');

  late bool cached;
  bool loaded = false;

  late List<CurrencyModel> currencies=[];

  bool darkTheme = false;

  Future<bool> saveTheme() async{
    await AppController.instance.storage.setItem('dark', darkTheme);
    return darkTheme;
  }

  toggleDarkTheme(){
    darkTheme = !darkTheme;
    print(darkTheme);
    notifyListeners();
  }

}