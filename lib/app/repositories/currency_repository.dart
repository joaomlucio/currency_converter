import 'package:currency_converter/app/controllers/app_controller.dart';
import 'package:currency_converter/app/models/currency_model.dart';
import 'package:graphql/client.dart';

class CurrencyRepository{

  late QueryOptions options;
  late GraphQLClient client;
  final url = 'https://currencyc-api.herokuapp.com/graphql';
  late AppController instance;


  CurrencyRepository({GraphQLClient? clientInit, AppController? instanceInit}){ 
    client = clientInit ?? GraphQLClient(cache: GraphQLCache(),link: HttpLink(url));
    instance = instanceInit ?? AppController.instance;
  }

  Future<List<CurrencyModel>> update() async{

    await instance.storage.ready;

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

    options = QueryOptions(
      document: gql(getCurrencies),
    );

    final QueryResult result = await client.query(options);

    List<CurrencyModel> curs = [];

    if(!result.hasException){
      final List<dynamic> data = result.data?['currencies'] as List<dynamic>;
      
      curs = data.map((value)=>CurrencyModel.fromMap(value)).toList();

      await instance.storage.setItem("currencies", curs);
      await instance.storage.setItem("cached", true);
    }
    
    return curs;
  }
}