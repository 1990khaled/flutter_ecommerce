class NewProduct {
  final String id;
  final String title;
  final double price;
  final String imgUrl;
  final double discountValue;
  final String script;
  final int qunInCarton;
  final int maximum;
  final int minimum;
  
  NewProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.imgUrl,
    this.discountValue = 0.1,
    required this.qunInCarton,
    this.script = "الكمية داخل العبوة ",
    this.maximum = 5,
    this.minimum = 1,
    
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imgUrl': imgUrl,
      'discountValue': discountValue,
      'qunInCarton': qunInCarton,
      'script': script,
      'maximum': maximum,
      'minimum': minimum,
      
    };
  }

  factory NewProduct.fromMap(Map<String, dynamic> map, String documentId) {
    return NewProduct(
      id: documentId,
      title: map['title'] as String,
      price: map['price'] as double,
      imgUrl: map['imgUrl'] as String,
      discountValue: map['discountValue'] as double,
      qunInCarton: map['qunInCarton'] as int,
      script: map['script'] as String,
      maximum: map['maximum'] as int,
      minimum: map['minimum'] as int,

    );
  }
}
