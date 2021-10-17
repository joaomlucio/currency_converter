import 'package:currency_converter/app/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:currency_converter/app/views/home_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CurrencyConverter extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    HomeView home = HomeView();
    return ValueListenableBuilder(
      valueListenable: Hive.box('darkThemeBox').listenable(),
      builder: (BuildContext context, Box darkBox, child) {
        AppController.instance.darkTheme = Hive.box('darkThemeBox').get('dark', defaultValue: false);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Currency Converter",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: AppController.instance.darkTheme
              ?Brightness.dark 
              :Brightness.light 
              //accentColor: Colors.blueAccent,
          ),
          initialRoute: '/',
          routes: {
            '/': (context) => home, 
          },
        );
    });
  }

}