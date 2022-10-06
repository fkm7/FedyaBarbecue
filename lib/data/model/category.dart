class Category {
  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.parent,
    required this.updatedAt,
    required this.productObj,
  });

  int id;
  String title;
  String? image;
  dynamic parent;
  DateTime updatedAt;
  List<ProductObj> productObj;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        parent: json["parent"],
        updatedAt: DateTime.parse(json["updated_at"]),
        productObj: List<ProductObj>.from(json["product_obj"].map((x) => ProductObj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "parent": parent,
        "updated_at": updatedAt.toIso8601String(),
        "product_obj": List<dynamic>.from(productObj.map((x) => x.toJson())),
      };
}

class ProductObj {
  ProductObj({
    required this.id,
    required this.title,
    required this.price,
    required this.selfPrice,
    required this.count,
    required this.updatedAt,
  });

  int id;
  String title;
  int price;
  int selfPrice;
  double count;
  DateTime updatedAt;

  factory ProductObj.fromJson(Map<String, dynamic> json) => ProductObj(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        selfPrice: json["self_price"],
        count: json["count"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "self_price": selfPrice,
        "count": count,
        "updated_at": updatedAt.toIso8601String(),
      };
}
