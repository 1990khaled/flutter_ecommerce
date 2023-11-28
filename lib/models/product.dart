class Product {
  final String id;
  final String title;
  final double price;
  final String imgUrl;
  final String category;
  final String script;
  final int qunInCarton;
  final int maximum;
  final int minimum;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.imgUrl,
      this.category = 'Other',
      required this.qunInCarton,
      this.script = "الكمية داخل العبوة ",
      this.maximum = 10,
      this.minimum = 1,
      });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'category': category,
      'qunInCarton': qunInCarton,
      'script': script,
      'maximum': maximum,
      'minimum': minimum,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String documentId) {
    return Product(
      id: documentId,
      title: map['title'] as String,
      price: map['price'] as double,
      imgUrl: map['imgUrl'] as String,
      category: map['category'] as String,
      qunInCarton: map['qunInCarton'] as int,
      script: map['script'] as String,
      maximum: map['maximum'] as int,
      minimum: map['minimum'] as int,
    );
  }
}
