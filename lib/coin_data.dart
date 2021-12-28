import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'USD',
  'EUR',
  'MYR',
  'JPY',
  'SGD'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'DOT',
  'DOGE'
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'A9A4A256-02AC-462F-9B4C-45A806F38DB0';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey';
      http.Response response = await http.get(Uri.parse(requestURL));

      if(response.statusCode == 200){
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(3);
      }
      else{
        print(response.statusCode);
        throw 'Problem';
      }
    }

    return cryptoPrices;
  }
}