import 'package:fedya_shashlik/data/model/category.dart';
import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:flutter/material.dart';

class CategoryBloc extends ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories => _categories;

  void fetchCategory() async {
    _categories = await ApiService.getInstance().getCategories();
    notifyListeners();
  }
}
