class FavouriteModel {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String imgUrl;
  final int qunInCarton;
  final String script;
  final int maximum;
  final int minimum;
 bool isFavourite;
  FavouriteModel({
    required this.id,
    required this.title,
    required this.price,
    required this.productId,
    required this.imgUrl,
    this.qunInCarton = 1,
    this.script = "الكمية داخل العبوة ",
    this.maximum = 5,
    this.minimum = 1,
    required this.isFavourite,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'productId': productId});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'qunInCarton': qunInCarton});
    result.addAll({'isFavourite': isFavourite,});
    result.addAll({
      'script': script,
    });
    result.addAll({
      'maximum': maximum,
    });
result.addAll({
      'minimum': minimum,
    });
    return result;
  }

  factory FavouriteModel.fromMap(Map<String, dynamic> map, String documentId) {
    return FavouriteModel(
      id: documentId,
      title: map['title'] ?? '',
      productId: map['productId'] ?? '',
      price: map['price'] ?? 0,
      imgUrl: map['imgUrl'] ?? '',
      qunInCarton: map['qunInCarton']?.toInt() ?? 0,
      script: map['script'] ?? '',
      maximum: map['maximum'] ?? 0,
      minimum: map['minimum'] ?? 0,
      isFavourite: map['isFavourite'] ?? false,
    );
  }
}
