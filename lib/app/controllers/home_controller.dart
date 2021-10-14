import 'dart:convert';
import 'package:currency_converter/app/enums/homeState_enum.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:currency_converter/app/controllers/app_controller.dart';
import 'package:currency_converter/app/enums/currency_enum.dart';
import 'package:currency_converter/app/repositories/currency_repository.dart';
import 'package:currency_converter/app/models/currency_model.dart';

class HomeController{

  List<CurrencyModel> currencies = [];
  late CurrencyModel fromCurrency;
  late CurrencyModel toCurrency;
  late CurrencyRepository repo;

  final TextEditingController fromText;
  final TextEditingController toText;

  final ValueNotifier<AppController> appInstance = ValueNotifier<AppController>(AppController.instance);
  final ValueNotifier<HomeState> state = ValueNotifier<HomeState>(HomeState.start);

  HomeController({required this.fromText, required this.toText, CurrencyRepository? repository}){
    repo = repository ?? CurrencyRepository();
    fromCurrency = CurrencyModel(name: '', rates: []);
    toCurrency = CurrencyModel(name: '', rates: []);
  }

  convert(){
    double value = double.tryParse(fromText.text.replaceAll(',', '.')) ?? 1.0;
    var test = fromCurrency.rates.where((value) => value['name']==(Currencies.getValue(toCurrency.name).toLowerCase())).toList();
    double exchange = test.isEmpty ? 1.0 : double.parse(test.first['value'].toString());
    double result = value*exchange;
    toText.text = result.toStringAsFixed(2);
  }

  Future start() async {
    state.value = HomeState.loading;

    var data = json.decode(await rootBundle.loadString('assets/data/currencies.json'));
    
    await appInstance.value.storage.ready;

    if(appInstance.value.storage.getItem('dark')!=null){
      AppController.instance.darkTheme.value = appInstance.value.storage.getItem('dark');
    }
    
    appInstance.value.cached = appInstance.value.storage.getItem('cached')!=null
                                                                          ?true
                                                                          :false;

    if(appInstance.value.cached){
      appInstance.value.storage.getItem('currencies').forEach(
        (value)=>currencies.add(
          CurrencyModel.fromJson(value)
        )
      );
    }else{
      data['currencies'].forEach(
        (value)=>currencies.add(
          CurrencyModel.fromMap(value)
        )
      );
    }
    fromCurrency = currencies[0];
    toCurrency = currencies[1];
    state.value = HomeState.success;
  }

  Future update() async {
    state.value = HomeState.loading;
    var c = await repo.update();
    if(c.isNotEmpty) {
      currencies = c;
      fromCurrency = currencies[0];
      toCurrency = currencies[2];
    }
    state.value = HomeState.success;
  }

}