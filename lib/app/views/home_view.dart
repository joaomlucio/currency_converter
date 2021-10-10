import 'package:currency_converter/app/components/currencyForm_component.dart';
import 'package:currency_converter/app/controllers/home_controller.dart';
import 'package:currency_converter/app/models/currency_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final TextEditingController fromText = TextEditingController();
  final TextEditingController toText = TextEditingController();
  
  late HomeController homeController;

  late List<CurrencyModel> currencies = [];

  late Future<List<CurrencyModel>> update;


  @override
  void initState(){
    update = HomeController.update();
    homeController = HomeController(toText: toText, fromText: fromText);
    super.initState();
  }
 
  Widget _body(){
    return SingleChildScrollView(
      child: FutureBuilder(
        initialData: homeController.currencies,
        future: update,
        builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          currencies = snapshot.data;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:30, left: 8, right: 8, bottom: 50),
                    child: Image.asset(
                              'assets/images/logo.png',
                              width: 150,
                              height: 150
                          ),
                  ),
                  CurrencyForm(
                    label: "From",
                    items:  homeController.currencies,
                    selectedItem: homeController.fromCurrency,
                    controller: homeController.fromText,
                    onChanged: (model){
                      setState((){
                        homeController.fromCurrency = model;
                      });
                    },
                  ),
                  CurrencyForm(
                    label: "To",
                    selectedItem: homeController.toCurrency,
                    items: homeController.currencies,
                    controller: homeController.toText,
                    onChanged: (model){
                      setState((){
                        homeController.toCurrency = model;
                      });
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top:20),
                      child: ElevatedButton(
                        onPressed:  (){
                          homeController.convert();
                        },
                        child: Text('Convert')
                      ),
                    ),
                  ),
                ],
              ),
            )
          );
        }else{
          return Center(
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator()
                ),
              )
          );
        }
      }),
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: (){
                setState((){
                  if(currencies.isNotEmpty){
                    homeController.currencies = currencies;
                    homeController.toCurrency = currencies[0];
                    homeController.fromCurrency = currencies[1];
                  }
                });
              },
              icon: Icon(
                Icons.refresh_rounded,
                size: 26.0,
              ),
              tooltip: 'Refresh Quotations',
            ),
          )
        ]
      ),
      body: _body(), 
    );
  }
}