class Currencies{
  static const CurrenciesMap = {
    "USD": "Dollar",
    "BRL": "Real",
    "EUR": "Euro",
    "GBP": "Pound"
  };
  static String getValue(value){
    return CurrenciesMap[value]!;
  }
}

