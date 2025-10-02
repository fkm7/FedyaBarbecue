class PromoResponse {
  dynamic next;
  dynamic nextPage;
  dynamic previous;
  dynamic previousPage;
  int count;
  int limit;
  List<Promo> results;

  PromoResponse({
    this.next,
    this.nextPage,
    this.previous,
    this.previousPage,
    required this.count,
    required this.limit,
    required this.results,
  });

  factory PromoResponse.fromJson(Map json) => PromoResponse(
        next: json['next'],
        nextPage: json['next_page'],
        previous: json['previous'],
        previousPage: json['previous_page'],
        count: json['count'],
        limit: json['limit'],
        results: List<Promo>.from(json['results'].map((x) => Promo.fromJson(x))),
      );
}

class Promo {
  int id;
  String image;

  Promo({
    required this.id,
    required this.image,
  });

  factory Promo.fromJson(Map json) => Promo(
        id: json['id'],
        image: json['image'],
      );

  Map toJson() => {
        'id': id,
        'image': image,
      };
}
