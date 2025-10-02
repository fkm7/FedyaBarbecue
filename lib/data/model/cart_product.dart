import 'package:fedya_shashlik/data/model/product.dart';

class CartProduct {
  int amount;
  double? total;
  Product product;

  CartProduct({
    required this.product,
    required this.amount,
    this.total,
  }) {
    total ??= (amount * product.price).toDouble();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is CartProduct && runtimeType == other.runtimeType && product == other.product;

  @override
  int get hashCode => product.hashCode;
}
