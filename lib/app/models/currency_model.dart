import 'dart:convert';

class CurrencyModel {

  final String? name;
  final List<Map<String, dynamic>>? rates;

  CurrencyModel({this.name, this.rates});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'rates': rates,
    };
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      name: map['name'],
      rates: List<Map<String, dynamic>>.from(map['rates']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrencyModel.fromJson(String source) => CurrencyModel.fromMap(json.decode(source));
}
