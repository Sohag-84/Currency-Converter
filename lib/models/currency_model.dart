class CurrencyModel {
  String? code;
  double? value;

  CurrencyModel({this.code, this.value});

  CurrencyModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    value = double.parse(json['value'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['value'] = value;
    return data;
  }
}
