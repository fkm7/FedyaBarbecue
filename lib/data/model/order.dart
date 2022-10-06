class OrderResponse {
  OrderResponse({
    this.next,
    this.nextPage,
    this.previous,
    this.previousPage,
    required this.count,
    required this.limit,
    this.results,
  });

  dynamic next;
  dynamic nextPage;
  dynamic previous;
  dynamic previousPage;
  int count;
  int limit;
  List<Order>? results;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        next: json["next"],
        nextPage: json["next_page"],
        previous: json["previous"],
        previousPage: json["previous_page"],
        count: json["count"],
        limit: json["limit"],
        results: json["results"] == null ? null : List<Order>.from(json["results"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "next": next,
        "next_page": nextPage,
        "previous": previous,
        "previous_page": previousPage,
        "count": count,
        "limit": limit,
        "results": results == null ? null : List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Order {
  Order({
    this.id,
    this.status,
    this.created,
    this.customerPhone,
    this.customerAddress,
    this.discountPercent,
    this.discountAmount,
    this.total,
    this.comment,
    this.updatedAt,
    this.orderItemObj,
  });

  int? id;
  String? status;
  DateTime? created;
  String? customerPhone;
  String? customerAddress;
  double? discountPercent;
  double? discountAmount;
  double? total;
  String? comment;
  DateTime? updatedAt;
  List<OrderItemObj>? orderItemObj;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        status: json["status"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        customerPhone: json["customer_phone"],
        customerAddress: json["customer_address"],
        discountPercent: json["discount_percent"],
        discountAmount: json["discount_amount"],
        total: json["total"],
        comment: json["comment"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        orderItemObj: json["order_item_obj"] == null
            ? null
            : List<OrderItemObj>.from(json["order_item_obj"].map((x) => OrderItemObj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "created": created == null ? null : created!.toIso8601String(),
        "customer_phone": customerPhone,
        "customer_address": customerAddress,
        "discount_percent": discountPercent,
        "discount_amount": discountAmount,
        "total": total,
        "comment": comment,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "order_item_obj": orderItemObj == null ? null : List<dynamic>.from(orderItemObj!.map((x) => x.toJson())),
      };
}

class OrderItemObj {
  OrderItemObj({
    this.id,
    this.created,
    this.price,
    this.count,
    this.total,
    this.updatedAt,
    this.productObj,
  });

  int? id;
  DateTime? created;
  double? price;
  double? count;
  double? total;
  DateTime? updatedAt;
  OrderItemObjProductObj? productObj;

  factory OrderItemObj.fromJson(Map<String, dynamic> json) => OrderItemObj(
        id: json["id"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
        price: json["price"],
        count: json["count"],
        total: json["total"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        productObj: json["product_obj"] == null ? null : OrderItemObjProductObj.fromJson(json["product_obj"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created": created == null ? null : created!.toIso8601String(),
        "price": price,
        "count": count,
        "total": total,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "product_obj": productObj == null ? null : productObj?.toJson(),
      };
}

class OrderItemObjProductObj {
  OrderItemObjProductObj({
    this.id,
    this.categoryId,
    this.title,
    this.price,
    this.selfPrice,
    this.count,
    this.updatedAt,
    this.productPhotoObj,
    this.productCategoryObj,
  });

  int? id;
  int? categoryId;
  String? title;
  int? price;
  int? selfPrice;
  double? count;
  DateTime? updatedAt;
  List<ProductPhotoObj>? productPhotoObj;
  ProductCategoryObj? productCategoryObj;

  factory OrderItemObjProductObj.fromJson(Map<String, dynamic> json) => OrderItemObjProductObj(
        id: json["id"],
        categoryId: json["category_id"],
        title: json["title"],
        price: json["price"],
        selfPrice: json["self_price"],
        count: json["count"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        productPhotoObj: json["product_photo_obj"] == null
            ? null
            : List<ProductPhotoObj>.from(json["product_photo_obj"].map((x) => ProductPhotoObj.fromJson(x))),
        productCategoryObj:
            json["product_category_obj"] == null ? null : ProductCategoryObj.fromJson(json["product_category_obj"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "title": title,
        "price": price,
        "self_price": selfPrice,
        "count": count,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "product_photo_obj": productPhotoObj == null ? null : List<dynamic>.from(productPhotoObj!.map((x) => x.toJson())),
        "product_category_obj": productCategoryObj == null ? null : productCategoryObj!.toJson(),
      };
}

class ProductCategoryObj {
  ProductCategoryObj({
    this.id,
    this.title,
    this.image,
    this.parent,
    this.updatedAt,
    this.productObj,
  });

  int? id;
  String? title;
  String? image;
  dynamic parent;
  DateTime? updatedAt;
  List<ProductCategoryObjProductObj>? productObj;

  factory ProductCategoryObj.fromJson(Map<String, dynamic> json) => ProductCategoryObj(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        parent: json["parent"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        productObj: json["product_obj"] == null
            ? null
            : List<ProductCategoryObjProductObj>.from(json["product_obj"].map((x) => ProductCategoryObjProductObj.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "parent": parent,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "product_obj": productObj == null ? null : List<dynamic>.from(productObj!.map((x) => x.toJson())),
      };
}

class ProductCategoryObjProductObj {
  ProductCategoryObjProductObj({
    this.id,
    this.title,
    this.price,
    this.selfPrice,
    this.count,
    this.updatedAt,
  });

  int? id;
  String? title;
  int? price;
  int? selfPrice;
  double? count;
  DateTime? updatedAt;

  factory ProductCategoryObjProductObj.fromJson(Map<String, dynamic> json) => ProductCategoryObjProductObj(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        selfPrice: json["self_price"],
        count: json["count"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "self_price": selfPrice,
        "count": count,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class ProductPhotoObj {
  ProductPhotoObj({
    this.id,
    this.product,
    this.photo,
    this.updatedAt,
  });

  int? id;
  int? product;
  String? photo;
  DateTime? updatedAt;

  factory ProductPhotoObj.fromJson(Map<String, dynamic> json) => ProductPhotoObj(
        id: json["id"],
        product: json["product"],
        photo: json["photo"],
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product,
        "photo": photo,
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
