import 'package:currency_converter/app/models/currency_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:currency_converter/app/views/home_view.dart';
import 'package:currency_converter/app/controllers/app_controller.dart';

class CurrencyConverter extends StatelessWidget{
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: AppController.instance,
      builder: (context, child){
        return FutureBuilder(
          future: AppController.instance.storage.ready,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.hasData){
            var cached = AppController.instance.storage.getItem("cached");
            //var dark = AppController.instance.storage.getItem("dark");
            AppController.instance.cached = cached != null ? cached : false;
            //if(dark!=null) AppController.instance.darkTheme = dark;
            if(AppController.instance.cached && AppController.instance.loaded==false){
              AppController.instance.storage.getItem('currencies').map((item)=>CurrencyModel.fromJson(item)).toList().forEach((item)=>AppController.instance.currencies.add(item));
              AppController.instance.loaded = true;
            }
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
                //'/': (context) => LoginPage(),
                '/home': (context) => HomeView(), 
              },
            );
          }else{
            AppController.instance.cached = false;
            return Center(
              child: Container(
                width: 26,
                height: 26,
                child: CircularProgressIndicator()
              )
            );
          }
        });
      }
    );
  }
  
}