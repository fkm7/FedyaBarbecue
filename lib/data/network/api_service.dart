import 'dart:convert';
import 'dart:io';

import 'package:fedya_shashlik/data/model/cart_product.dart';
import 'package:fedya_shashlik/data/model/category.dart';
import 'package:fedya_shashlik/data/model/order.dart';
import 'package:fedya_shashlik/data/model/product.dart';
import 'package:fedya_shashlik/data/model/promo.dart';
import 'package:fedya_shashlik/data/network/api.dart';
import 'package:fedya_shashlik/prefs/user.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class ApiService {
  final API api;

  ApiService(this.api);

  ApiService._(this.api);

  static final ApiService _instance = ApiService._(API());

  static ApiService getInstance() {
    return _instance;
  }

  Future checkPhoneNumber(String phone) async {
    final response = await http.post(
      api.endpointUri(Endpoint.auth),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'phone': phone}),
    );
    if (response.statusCode == 200) {
      // print(response.body);
      final responseBody = utf8.decode(response.bodyBytes);
      final responseObj = json.decode(responseBody);
      return responseObj['msg'];
    }
    throw response.statusCode;
  }

  Future smsVerification(String phone, String code) async {
    final response = await http.post(
      api.endpointUri(Endpoint.sms),
      headers: {'content-type': 'application/json'},
      body: jsonEncode({'phone': phone, 'sms_code': code}),
    );
    if (response.statusCode == 200) {
      // print(response.body);
      final responseBody = utf8.decode(response.bodyBytes);
      final responseObj = json.decode(responseBody);
      if (responseObj["token"] != null) {
        await UserPreferences.getInstance().saveToken(responseObj["token"]);
        return response.statusCode;
      }
    }
    return response.statusCode;
    // throw response.statusCode;
  }

  Future editName(String phone, String name) async {
    final token = await UserPreferences.getInstance().getToken();
    final response = await http.post(
      api.endpointUri(Endpoint.name),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
      body: jsonEncode({'name': name, 'phone': phone}),
    );
    if (response.statusCode == 200) {
      // print(response.body);
      await UserPreferences.getInstance().saveFirstName(name);
      return response.statusCode;
    }
    throw response.statusCode;
  }

  Future getUserDetail({required String phone}) async {
    final token = await UserPreferences.getInstance().getToken();
    final response = await retry(() async => await http.get(
          api.userDetail(phone: phone),
          headers: {
            HttpHeaders.contentEncodingHeader: 'utf-8',
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ));
    if (response.statusCode == 200) {
      // print(response.body);
      final responseBody = utf8.decode(response.bodyBytes);
      final responseObj = json.decode(responseBody);
      final arg = responseObj['msg'];
      await UserPreferences.getInstance().saveFirstName(arg['first_name']);
      await UserPreferences.getInstance().saveLastName(arg['last_name']);
      return;
    }
    throw response.statusCode;
  }

  Future<List<Product>> getProducts() async {
    final response = await retry(() async => await http.get(
          api.productsUri(),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.contentEncodingHeader: 'utf-8',
          },
        ));
    if (response.statusCode == 200) {
      // print(response.body);
      final responseBody = utf8.decode(response.bodyBytes);
      final responseObj = json.decode(responseBody);
      List<Product> products = [];
      responseObj['results'].forEach((e) => products.add(Product.fromJson(e)));
      return products;
    }
    throw response.reasonPhrase!;
  }

  Future<List<Promo>> getPromos() async {
    final response = await retry(() async => await http.get(
          api.promoUri(),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ));
    if (response.statusCode == 200) {
      final responseBody = utf8.decode(response.bodyBytes);
      final responseObj = json.decode(responseBody);
      var object = PromoResponse.fromJson(responseObj);
      return object.results;
    }
    throw response.statusCode;
  }

  Future<OrderResponse> getOrdersByUser({String? phoneNumber}) async {
    String requestArg;
    if (phoneNumber != null) {
      requestArg = phoneNumber;
    } else {
      requestArg = (await UserPreferences.getInstance().getPhoneNumber())!;
    }
    // requestArg = requestArg.replaceFirst('+', '');
    requestArg = requestArg.trim();
    final response = await retry(() async => await http.get(
          api.orderUri(phone: requestArg),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ));
    if (response.statusCode == 200) {
      // print(response.body);
      final responseBody = utf8.decode(response.bodyBytes);
      final responseObj = jsonDecode(responseBody);
      return OrderResponse.fromJson(responseObj);
    }
    throw response.statusCode;
  }

  Future<List<Category>> getCategories() async {
    final response = await retry(() async => await http.get(
          api.categoriesUri(),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            HttpHeaders.contentEncodingHeader: 'utf-8',
          },
        ));
    if (response.statusCode == 200) {
      // print(response.body);
      final responseBody = utf8.decode(response.bodyBytes);
      final responseObj = json.decode(responseBody);
      List<Category> categories = [];
      responseObj['results'].forEach((e) => categories.add(Category.fromJson(e)));
      return categories;
    }
    throw response.statusCode;
  }

  Future<int> sendOrder({
    required List<CartProduct> products,
    required double total,
    required String address,
  }) async {
    var phone = await UserPreferences.getInstance().getPhoneNumber();
    var payload = {
      "order": {
        "customer_phone": phone,
        "customer_address": address,
        "discount_percent": "0",
        "discount_amount": "0",
        "total": total,
        "comment": "",
        "order_items": products
            .map((e) => {
                  "product_id": e.product.id,
                  "price": e.product.price,
                  "count": e.amount,
                  "total": e.total,
                })
            .toList()
      },
      "phone": phone,
    };
    final response = await http.post(api.ordersUri(),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.contentEncodingHeader: "utf-8",
        },
        body: jsonEncode(payload));
    print(response.body);
    return response.statusCode;
  }

  Future postToken({
    required String phone,
    required String token,
  }) async {
    final response = await http.post(
      // Uri.parse('http://192.168.0.171:8000/api/v1/user/cloud_token/'),
      Uri.parse('http://85.143.175.111:4411/api/v1/user/cloud_token/'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({
        'phone': phone,
        'token': token,
      }),
    );
    return response.statusCode;
  }
}
