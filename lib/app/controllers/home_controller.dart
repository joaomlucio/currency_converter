import 'package:currency_converter/app/controllers/app_controller.dart';
import 'package:currency_converter/app/enums/currency_enum.dart';
import 'package:flutter/widgets.dart';
import 'package:graphql/client.dart';
import 'package:currency_converter/app/models/currency_model.dart';

class HomeController{

  late List<CurrencyModel> currencies;
  late CurrencyModel fromCurrency;
  late CurrencyModel toCurrency;

  final TextEditingController fromText;
  final TextEditingController toText;

  HomeController({required this.fromText, required this.toText}) {
    List<Map<String, dynamic>> data = [
      {
        "name": "EUR",
        "rates": [
          {"name": "dollar",
          "value": 1.159373},
          {"name": "real",
          "value": 6.349658},
          {"name": "pound",
          "value": 0.851194}
        ]
      },
      {
        "name": "USD",
        "rates": [
          {"name": "euro",
          "value": 0.862535180653681},
          {"name": "real",
          "value": 5.47680341011909},
          {"name": "pound",
          "value": 0.7341847705613292}
        ]
      },
      {
        "name": "BRL",
        "rates": [
          {"name": "euro",
          "value": 0.15748879703442295},
          {"name": "dollar",
          "value": 0.18258825908419005},
          {"name": "pound",
          "value": 0.13405351910291863}
        ]
      },
      {
        "name": "GBP",
        "rates": [
          {"name": "euro",
          "value": 1.1748203112333968},
          {"name": "real",
          "value": 7.459707187785628},
          {"name": "dollar",
          "value": 1.362054948695597},
        ]
      }
    ];

    currencies = AppController.instance.loaded ? AppController.instance.currencies : data.map((value)=>CurrencyModel.fromMap(value)).toList();
    fromCurrency = currencies[0];
    toCurrency = currencies[1];
  }

  convert(){
    double value = double.tryParse(fromText.text.replaceAll(',', '.')) ?? 1.0;
    var test = fromCurrency.rates.where((value) => value['name']==(Currencies.getValue(toCurrency.name).toLowerCase())).toList();
    double exchange = test.isEmpty ? 1.0 : double.parse(test.first['value'].toString());
    double result = value*exchange;
    toText.text = result.toStringAsFixed(2);
  }
  
  static Future<List<CurrencyModel>> update() async{

    await AppController.instance.storage.ready;

    const String getCurrencies = r'''
      query {
        currencies{
          name
          rates{
            name
            value
          }
        }
      }''';

    final QueryOptions options = QueryOptions(
      document: gql(getCurrencies),
    );

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink("https://currencyc-api.herokuapp.com/graphql"),
    );

    final QueryResult result = await client.query(options);

    List<CurrencyModel> curs;

    if(!result.hasException){
      
      final List<dynamic> data = result.data?['currencies'] as List<dynamic>;
      
      curs = data.map((value)=>CurrencyModel.fromMap(value)).toList();

      await AppController.instance.storage.setItem("currencies", curs);

      await AppController.instance.storage.setItem("cached", true);

      return curs; 

    }else{ 
      curs = AppController.instance.storage.getItem("currencies").map((value)=>CurrencyModel.fromMap(value)).toList();

      return curs;

    }
  }
}