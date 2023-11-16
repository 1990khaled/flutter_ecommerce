class AddToCartModel {
  final String id;
  final String productId;
  String collectionPath;
  final String title;
  final double price;
  int quantity;
  final String imgUrl;
  final int qunInCarton;



  AddToCartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.productId,
    this.collectionPath = "",
    this.quantity = 1,
    required this.imgUrl,
    this.qunInCarton = 1,
  });

int get numberOfParameters => 3;

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'productId': productId});
    result.addAll({'title': title});
    result.addAll({'price': price});
    result.addAll({'quantity': quantity});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'qunInCarton': qunInCarton});
    result.addAll({'collectionPath': collectionPath});
    return result;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AddToCartModel(
      id: documentId,
      title: map['title'] ?? '',
      collectionPath: map['collectionPath'] ?? '',
      productId: map['productId'] ?? '',
      price: map['price'] ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      imgUrl: map['imgUrl'] ?? '',
      qunInCarton: map['qunInCarton']?.toInt() ?? 0,
    );
  }
}
