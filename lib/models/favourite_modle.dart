class FavouriteModel {
  final String id;
  final String productId;
  final String title;
  final double price;
  final String imgUrl;
  final int qunInCarton;

  FavouriteModel({
    required this.id,
    required this.title,
    required this.price,
    required this.productId,
    required this.imgUrl,
    this.qunInCarton = 1,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'productId': productId});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'qunInCarton': qunInCarton});
    
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
    );
  }
}
