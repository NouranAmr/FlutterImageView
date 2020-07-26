import 'package:mytestingflutter/response/CarSalesBrandModel.dart';

class Categories {
  List<CarSalesBrandModel> _categories;

  Categories({List<CarSalesBrandModel> categories}) {
    this._categories = categories;
  }

  List<CarSalesBrandModel> get categories => _categories;
  set categories(List<CarSalesBrandModel> categories) => _categories = categories;

  Categories.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      _categories = new List<CarSalesBrandModel>();
      json['categories'].forEach((v) {
        _categories.add(new CarSalesBrandModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._categories != null) {
      data['categories'] = this._categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}