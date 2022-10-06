import 'package:fedya_shashlik/data/model/product.dart';
import 'package:fedya_shashlik/data/network/api_service.dart';
import 'package:flutter/foundation.dart';

class ProductBloc extends ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void fetchProducts() async {
    _products = await ApiService.getInstance().getProducts();
    notifyListeners();
  }

  List<Product> getByCategory(int id) {
    List<Product> prs = [];
    for (var element in _products) {
      if (element.productCategoryObj?.id == id) {
        prs.add(element);
      }
    }
    return prs;
  }
}
