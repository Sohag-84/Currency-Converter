// ignore_for_file: prefer_const_constructors

import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/utils/utils.dart';
import 'package:flutter/material.dart';

Widget dropDownItem(Country country) {
  return Row(
    children: [
      CountryPickerUtils.getDefaultFlagImage(country),
      SizedBox(height: 8),
      Text("${country.currencyCode}"),
    ],
  );
}
