class AddToCartModel {
  final String id;
  final String productId;
  String script;
  final String title;
  final double price;
  int quantity;
  final String imgUrl;
  final int qunInCarton;
  final int maximum;
  final int storeBalance;
  final int minimum;

  AddToCartModel({
    required this.id,
    required this.title,
    required this.price,
    required this.productId,
    this.script = "الكمية داخل العبوة",
    this.quantity = 1,
    required this.imgUrl,
    this.qunInCarton = 1,
    this.maximum = 5,
    this.minimum = 1,
    this.storeBalance = 1,

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
    result.addAll({'script': script});
    result.addAll({'maximum': maximum});
    result.addAll({'minimum': minimum});
    result.addAll({'storeBalance': storeBalance});
    return result;
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map, String documentId) {
    return AddToCartModel(
      id: documentId,
      title: map['title'] ?? '',
      script: map['script'] ?? '',
      productId: map['productId'] ?? '',
      price: map['price'] ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      imgUrl: map['imgUrl'] ?? '',
      maximum: map['maximum']?.toInt() ?? 0,
      minimum: map['minimum']?.toInt() ?? 0,
      qunInCarton: map['qunInCarton']?.toInt() ?? 0,
      storeBalance: map['storeBalance']?.toInt() ?? 0,
    );
  }
}
