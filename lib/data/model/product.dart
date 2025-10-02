class ProductCategoryObj {
  ProductCategoryObj({
    required this.id,
    required this.title,
    required this.parent,
    required this.updatedAt,
    required this.productObj,
  });

  int id;
  String title;
  dynamic parent;
  DateTime updatedAt;
  List<Product> productObj;

  factory ProductCategoryObj.fromJson(Map<String, dynamic> json) => ProductCategoryObj(
        id: json["id"],
        title: json["title"],
        parent: json["parent"],
        updatedAt: DateTime.parse(json["updated_at"]),
        productObj: List<Product>.from(json["product_obj"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "parent": parent,
        "updated_at": updatedAt.toIso8601String(),
        "product_obj": List<dynamic>.from(productObj.map((x) => x.toJson())),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCategoryObj &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          parent == other.parent &&
          updatedAt == other.updatedAt &&
          productObj == other.productObj;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ parent.hashCode ^ updatedAt.hashCode ^ productObj.hashCode;
}

class Product {
  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.selfPrice,
    required this.count,
    required this.updatedAt,
    required this.productPhotoObj,
    required this.productCategoryObj,
  });

  int id;
  String title;
  int price;
  int selfPrice;
  double count;
  DateTime updatedAt;
  List<ProductPhotoObj> productPhotoObj;
  ProductCategoryObj? productCategoryObj;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        selfPrice: json["self_price"],
        count: json["count"],
        updatedAt: DateTime.parse(json["updated_at"]),
        productPhotoObj: json["product_photo_obj"] != null
            ? List<ProductPhotoObj>.from(json["product_photo_obj"].map((x) => ProductPhotoObj.fromJson(x)))
            : [],
        productCategoryObj:
            json["product_category_obj"] != null ? ProductCategoryObj.fromJson(json["product_category_obj"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "self_price": selfPrice,
        "count": count,
        "updated_at": updatedAt.toIso8601String(),
        "product_photo_obj": productPhotoObj != null ? List<dynamic>.from(productPhotoObj.map((x) => x.toJson())) : [],
        "product_category_obj": productCategoryObj != null ? productCategoryObj!.toJson() : null,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          price == other.price &&
          selfPrice == other.selfPrice &&
          count == other.count &&
          updatedAt == other.updatedAt &&
          productPhotoObj == other.productPhotoObj &&
          productCategoryObj == other.productCategoryObj;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      price.hashCode ^
      selfPrice.hashCode ^
      count.hashCode ^
      updatedAt.hashCode ^
      productPhotoObj.hashCode ^
      productCategoryObj.hashCode;
}

class ProductPhotoObj {
  ProductPhotoObj({
    required this.id,
    required this.photo,
    required this.updatedAt,
  });

  int id;
  String? photo;
  DateTime updatedAt;

  factory ProductPhotoObj.fromJson(Map<String, dynamic> json) => ProductPhotoObj(
        id: json["id"],
        photo: json["photo"],
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductPhotoObj &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          photo == other.photo &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => id.hashCode ^ photo.hashCode ^ updatedAt.hashCode;
}
