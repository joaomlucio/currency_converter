import 'package:flutter/material.dart';

import 'package:currency_converter/app/enums/currency_enum.dart';
import 'package:currency_converter/app/models/currency_model.dart';

// ignore: must_be_immutable
class CurrencyForm extends StatelessWidget {
  

  TextEditingController controller;
  String label;
  CurrencyModel selectedItem;
  List<CurrencyModel> items;
  void Function(dynamic) onChanged;
  


  CurrencyForm({
    Key? key,
    required this.label,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    required this.controller
  }) : super(key: key);

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  TextFormField currencyValueForm(label){
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Form _currenciesForm(String label){
    return Form(
      key:_formkey,
      child: Column(
        children: [ 
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: currencyValueForm(label),
          )
        ]
      )
    );
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom:10, top: 35),
            child: DropdownButton<CurrencyModel>(  
              isExpanded: true,
              value: selectedItem,
              underline:Container(height: 1, color: Colors.blue),
              items: items.map<DropdownMenuItem<CurrencyModel>>(
                (CurrencyModel item) => DropdownMenuItem<CurrencyModel>(
                  value: item,
                  child: Text(
                    Currencies.getValue(item.name)
                  )
                )
              ).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: _currenciesForm(this.label)
        ),
      ]);
  }
}
