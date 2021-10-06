import 'package:currency_converter/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

main(){

  final TextEditingController fromText = TextEditingController();
  final TextEditingController toText = TextEditingController();
  
  final controller = HomeController(toText: toText, fromText: fromText);

  test('deve converter de real para dollar',() async{
    controller.currencies = await HomeController.update();
    print(controller.currencies);
    fromText.text = '2.0';
    controller.convert();
    //print(controller.fromCurrency?.name);
    //print(controller.toCurrency?.name);
    expect(toText.text,'10.96');
  });
}