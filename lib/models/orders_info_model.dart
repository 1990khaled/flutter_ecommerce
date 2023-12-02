class OrdersInfoModel {
  final String id;
  String customerName;
  String date;
  
  OrdersInfoModel({
    required this.id,
    required this.customerName,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'date': date,
          };
  }

  factory OrdersInfoModel.fromMap(Map<String, dynamic> map, String documentId) {
    return OrdersInfoModel(
      id: documentId,
      customerName: map['customerName'] ?? '',
      date: map['date'] ?? '',
      );
  }
}


