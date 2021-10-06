import 'package:currency_converter/app/components/currencyForm_component.dart';
import 'package:currency_converter/app/controllers/app_controller.dart';
import 'package:currency_converter/app/controllers/home_controller.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  final TextEditingController fromText = TextEditingController();
  final TextEditingController toText = TextEditingController();
  
  late HomeController homeController;

  @override
  void initState(){
    super.initState();
    homeController = HomeController(toText: toText, fromText: fromText);
  }
 
  Widget _body(){
    return SingleChildScrollView(
      child: FutureBuilder(
        future: HomeController.update(),
        builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.hasData){
          homeController.currencies = snapshot.data;
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
                    controller: homeController.fromText,
                    onChanged: (model){
                      setState((){
                        homeController.toCurrency = model;
                      });
                    },
                    selectedItem: homeController.fromCurrency,
                  ),
                  CurrencyForm(
                    label: "To",
                    items: homeController.currencies,
                    controller: homeController.toText,
                    onChanged: (model){
                      setState((){
                        homeController.toCurrency = model;
                      });
                    },
                    selectedItem: homeController.toCurrency,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top:20),
                      child: ElevatedButton(
                        onPressed: (){
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
      }),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: null,
              accountEmail: null,
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: Image.network('')
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/home');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('LogOut'),
              onTap: (){
                Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
        )
      ),
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: (){
                AppController.instance.toggleDarkTheme();
              },
              icon: Icon(
                Icons.dark_mode,
                size: 26.0,
              ),
              tooltip: 'Toggle Dark Theme',
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              onPressed: (){
                setState((){
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