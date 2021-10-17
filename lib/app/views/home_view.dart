import 'package:currency_converter/app/components/currencyForm_component.dart';
import 'package:currency_converter/app/controllers/app_controller.dart';
import 'package:currency_converter/app/controllers/home_controller.dart';
import 'package:currency_converter/app/enums/homeState_enum.dart';
import 'package:currency_converter/app/repositories/currency_repository.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: must_be_immutable
class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final TextEditingController fromText = TextEditingController();
  final TextEditingController toText = TextEditingController();

  CurrencyRepository repo = CurrencyRepository();
  
  late HomeController homeController;

  _start(){
    return Container();
  }

  _loading(){
    return Center(
      child: Padding(
        padding: EdgeInsets.all(50),
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator()
        ),
      )
    );
  }

  _success(){
    return ValueListenableBuilder(
      valueListenable: homeController.appInstance,
      builder: (BuildContext context, AppController appInstance, child){
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
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
      }
    );
  }

  stateManagement(HomeState state){
    switch(state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      default:
        return _start();
    }
  }

  @override
  void initState(){
    super.initState();
    homeController = HomeController(toText: toText, fromText: fromText, repository: repo);
    homeController.start();
  }
  
  Widget _body(){
    return SingleChildScrollView(
      child: ValueListenableBuilder(
        valueListenable: homeController.state,
        builder: (context, HomeState state, child) {
          return stateManagement(state);
        }
      )  
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
                homeController.update();
              },
              icon: Icon(
                Icons.refresh_rounded,
                size: 26.0,
              ),
              tooltip: 'Refresh Quotations',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: (){
                setState(() {
                  homeController.appInstance.value.darkTheme = !homeController.appInstance.value.darkTheme; 
                  Hive.box('darkThemeBox').put('dark', homeController.appInstance.value.darkTheme);  
                });
              },
              icon: Icon(
                Icons.dark_mode_outlined,
                size: 26.0,
              ),
              tooltip: 'Toggle Dark Mode',
            ),
          )
        ]
      ),
      body: _body(), 
    );
  }
}