// ignore_for_file: prefer_const_constructors

import 'package:currency_converter/models/currency_model.dart';
import 'package:flutter/material.dart';

class AllCurrencyList extends StatelessWidget {
  final CurrencyModel currencyModel;
  const AllCurrencyList({Key? key, required this.currencyModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue.withAlpha(88),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            currencyModel.code.toString(),
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
          Text(
            currencyModel.value!.toStringAsFixed(3),
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
