import 'dart:async';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'APIKEYS.dart';


//import 'package:flutter_flux/flutter_flux.dart';


class DeribitClient {
  bool testnet;

  final String baseUrl = 'https://www.deribit.com/api/v2/';
  final String baseUrlTestnet = 'https://test.deribit.com/api/v2/';
//  DeribitClient({this.api_key, this.api_secret, this.testnet})


  DeribitClient () {
    final secureStore = FlutterSecureStorage();

    secureStore.deleteAll();

    secureStore.read(key: 'apiKey').then( (String val) {

      print("Initially, the value of apiKey is: $val");

      if (val == null) {
        // pull from text file
         secureStore.write(key: 'apiKey', value: API_KEY);
         secureStore.write(key: 'apiSecret', value: API_SECRET);
      }
      secureStore.read(key: 'apiKey').then( (String newVal) => print("Ok, final value in apiKey is: $newVal"));
    });

    testnet = true;
  }



  Future<String> getIndex() async {
//    var client = http.Client();
//    var streamedresp = await client.send(http.Request('get', Uri.parse(this.baseUrlTest + 'public/get_index' + '?currency=BTC')));

    http.Response getresp = await http.get(this.baseUrlTestnet + 'public/get_index' + '?currency=BTC');

    if (getresp.statusCode == 200){
      return json.decode(getresp.body)['result']['BTC'].toString();   // return result
    }else{
      throw Exception('Request failed with status code ${getresp.statusCode}');
    }
  }


}
