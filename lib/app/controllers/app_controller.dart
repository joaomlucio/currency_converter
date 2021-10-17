import 'package:localstorage/localstorage.dart';

class AppController{
  
  static AppController instance = AppController();

  LocalStorage storage = new LocalStorage('data');

  late bool cached;

  late bool darkTheme;

}