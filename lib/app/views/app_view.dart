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
            var dark = AppController.instance.storage.getItem("dark");
            AppController.instance.cached = cached != null ? cached : false;
            AppController.instance.darkTheme = dark != null ? dark : AppController.instance.darkTheme;
            if(AppController.instance.cached && AppController.instance.loaded==false){
              AppController.instance.storage.getItem('currencies').forEach((value)=>AppController.instance.currencies.add(CurrencyModel.fromJson(value)));
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
                //accentColor: Colors.blueAccent,
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
                width: 100,
                height:100,
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  backgroundColor: AppController.instance.darkTheme
                    ? Colors.black 
                    : Colors.white,
                  )
              )
            );
          }
        });
      }
    );
  }
  
}