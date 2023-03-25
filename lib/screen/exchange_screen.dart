// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields

import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:currency_converter/services/api_services.dart';
import 'package:currency_converter/widgets/drop_down_item.dart';
import 'package:flutter/material.dart';

class ExchangeScreen extends StatefulWidget {
  const ExchangeScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeScreen> createState() => _ExchangeScreenState();
}

class _ExchangeScreenState extends State<ExchangeScreen> {
  String _selectedBaseCurrency = "USD";
  TextEditingController textController = TextEditingController();
  String _targetCurrency = "USD";
  String _totalValue = "";

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Text(
          "Base Currency",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CountryPickerDropdown(
            initialValue: "us",
            itemBuilder: dropDownItem,
            onValuePicked: (Country? country) {
              setState(() {
                _selectedBaseCurrency = country!.currencyCode ?? "";
              });
            },
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          width: 300,
          child: TextField(
            controller: textController,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          "Target Currency",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 8),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CountryPickerDropdown(
            initialValue: "us",
            itemBuilder: dropDownItem,
            onValuePicked: (Country? country) {
              setState(() {
                _targetCurrency = country!.currencyCode ?? "";
              });
            },
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (textController.text.isNotEmpty) {
              ApiServices()
                  .getExchangeCurrency(
                baseCurrency: _selectedBaseCurrency,
                targeCurrency: _targetCurrency,
              )
                  .then((result) {
                double value = double.parse(textController.text);
                double exchangeRate = double.parse(result[0].value.toString());
                double total = value * exchangeRate;
                _totalValue = total.toStringAsFixed(3).toString();
                setState(() {});
              });
            }
          },
          child: Text("Exchange"),
        ),
        SizedBox(height: 5),
        Text(
          "$_totalValue $_targetCurrency",
          style: TextStyle(color: Colors.greenAccent, fontSize: 30),
        )
      ],
    );
  }
}
