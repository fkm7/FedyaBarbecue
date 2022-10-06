import 'package:fedya_shashlik/data/model/cart_product.dart';
import 'package:flutter/cupertino.dart';

class Cart extends ChangeNotifier {
  List<CartProduct> _products = [];
  int amount = 0;
  double total = 0.0;

  List<CartProduct> get products => _products;

  void clear() {
    total = 0.0;
    amount = 0;
    _products.clear();
    notifyListeners();
  }

  void insert(CartProduct cartProduct) {
    if (_products.contains(cartProduct)) {
      _products.firstWhere((element) {
        if (element == cartProduct) {
          element.amount += cartProduct.amount;
          element.total = element.total ?? 0.0 + (cartProduct.total ?? 0.0);
          total += cartProduct.total!;
          amount += cartProduct.amount;
        }
        return element == cartProduct;
      });
    } else {
      _products.add(cartProduct);
      amount += cartProduct.amount;
      total += cartProduct.total!;
    }
    notifyListeners();
  }

  void remove(CartProduct cartProduct) {
    _products.remove(cartProduct);
    amount -= cartProduct.amount;
    notifyListeners();
  }

  void decreaseAmount(CartProduct cartProduct) {
    if (_products
            .singleWhere((element) => identical(element, cartProduct))
            .amount <=
        1) {
      remove(
          _products.singleWhere((element) => identical(element, cartProduct)));
    } else {
      _products
          .singleWhere((element) => identical(element, cartProduct))
          .amount--;
      total -= _products
          .singleWhere((element) => identical(element, cartProduct))
          .product
          .price;
      amount--;
    }
    notifyListeners();
  }

  void increaseAmount(CartProduct cartProduct) {
    _products
        .singleWhere((element) => identical(element, cartProduct))
        .amount++;
    total += _products
        .singleWhere((element) => identical(element, cartProduct))
        .product
        .price;
    amount++;
    notifyListeners();
  }
}
