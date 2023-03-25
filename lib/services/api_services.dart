import 'dart:convert';

import 'package:currency_converter/constant/constant.dart';
import 'package:currency_converter/models/currency_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<CurrencyModel>> getLatest({required String baseCurrency}) async {
    List<CurrencyModel> currencyModelList = [];

    String url = "${baseUrl}apikey=$apiKey&base_currency=$baseCurrency";

    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        Map<String, dynamic> body = json['data'];

        body.forEach((key, value) {
          CurrencyModel currencyModel = CurrencyModel.fromJson(value);
          currencyModelList.add(currencyModel);
        });
        return currencyModelList;
      } else {
        return [];
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
