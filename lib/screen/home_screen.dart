// ignore_for_file: prefer_const_constructors

import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/country_picker_dropdown.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:currency_converter/models/currency_model.dart';
import 'package:currency_converter/services/api_services.dart';
import 'package:currency_converter/widgets/all_currency_list.dart';
import 'package:currency_converter/widgets/drop_down_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCode = "USD";

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
                _selectedCode = country!.currencyCode ?? "";
              });
            },
          ),
        ),
        SizedBox(height: 10),
        Text(
          "All Currency",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 8),
        FutureBuilder(
          future: ApiServices().getLatest(baseCurrency: _selectedCode),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<CurrencyModel> currencyModelList = snapshot.data ?? [];
              return Expanded(
                child: ListView.builder(
                  itemCount: currencyModelList.length,
                  itemBuilder: (context, index) {
                    return AllCurrencyList(
                      currencyModel: currencyModelList[index],
                    );
                  },
                ),
              );
            }
          },
        )
      ],
    );
  }
}
