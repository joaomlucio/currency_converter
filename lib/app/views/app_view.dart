import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:currency_converter/app/views/home_view.dart';
import 'package:currency_converter/app/controllers/app_controller.dart';
import 'package:currency_converter/app/views/login_view.dart';

class CurrencyConverter extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Currency Converter",
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: AppController.instance.darkTheme 
                        ? Brightness.dark 
                        : Brightness.light,
            accentColor: Colors.blueAccent,
          ),
          initialRoute: '/home',
          routes: {
            '/': (context) => LoginPage(),
            '/home': (context) => HomeView(), 
          },
        );
      }
    );
  }
  
}