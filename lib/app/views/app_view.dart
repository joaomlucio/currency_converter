import 'package:currency_converter/app/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:currency_converter/app/views/home_view.dart';

class CurrencyConverter extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    HomeView home = HomeView();
    return ValueListenableBuilder(
      valueListenable: AppController.instance.darkTheme,
      builder: (BuildContext context, bool dark, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Currency Converter",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: dark 
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