enum Endpoint {
  products,
  categories,
  orders,
  token,
  auth,
  sms,
  name,
  detail,
  promo,
}

class API {
  API({this.apiKey});

  final String? apiKey;

  factory API.sandbox() => API();

  static const String host = '85.143.175.111';

  // static const String host = '192.168.0.171';

  static const int port = 4411;

  // static const int port = 8000;

  Uri tokenUri() => Uri(
        scheme: 'http',
        host: host,
        port: port,
        path: _path[Endpoint.token],
      );

  Uri productsUri() => Uri(
        scheme: 'http',
        host: host,
        port: port,
        path: _path[Endpoint.products],
      );

  Uri ordersUri() => Uri(
        scheme: 'http',
        host: host,
        port: port,
        path: _path[Endpoint.orders],
      );

  Uri categoriesUri() => Uri(
        scheme: 'http',
        host: host,
        port: port,
        path: _path[Endpoint.categories],
      );

  Uri orderUri({required String phone}) => Uri(
        scheme: 'http',
        host: host,
        port: port,
        path: _path[Endpoint.orders],
        queryParameters: {'user__username': phone},
      );

  Uri currentOrderUri({required int index}) => Uri(
        scheme: 'http',
        host: host,
        port: port,
        path: _path[Endpoint.orders],
        query: '$index/',
      );

  Uri userDetail({required String phone}) {
    return Uri(
      scheme: 'http',
      host: host,
      port: port,
      path: _path[Endpoint.detail]!,
      queryParameters: {
        'phone': phone,
      },
    );
  }

  Uri promoUri() {
    return Uri(
      scheme: 'http',
      host: host,
      port: port,
      path: _path[Endpoint.promo],
    );
  }

  Uri endpointUri(Endpoint endpoint, {String? query, String? arg}) {
    if (query != null && arg != null) {
      return Uri(
        scheme: 'http',
        host: host,
        port: port,
        path: _path[endpoint]!,
        queryParameters: {
          query: arg,
        },
      );
    }
    if (query != null && arg == null) {
      return Uri(
        scheme: 'http',
        host: host,
        port: port,
        path: _path[endpoint]!,
        query: query,
      );
    }
    return Uri(
      scheme: 'http',
      host: host,
      port: port,
      path: _path[endpoint]!,
    );
  }

  static final Map<Endpoint, String> _path = {
    Endpoint.categories: 'api/v1/categories/',
    Endpoint.orders: 'api/v1/orders/',
    Endpoint.products: 'api/v1/products/',
    Endpoint.token: 'api/v1/token/',
    Endpoint.auth: 'api/v1/user/auth/',
    Endpoint.sms: 'api/v1/user/sms/',
    Endpoint.name: 'api/v1/user/name/',
    Endpoint.detail: 'api/v1/user/detail/',
    Endpoint.promo: 'api/v1/promos/',
  };
}
