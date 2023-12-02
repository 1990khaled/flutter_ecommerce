import 'package:flutter_ecommerce/models/add_to_cart_model.dart';

class OrdersModel {
  final String id;
  String date;
  double totalAmount;
  String customerName;
  List<AddToCartModel> theOrder;
  String shippingAddress;

  OrdersModel({
    required this.id,
    required this.date,
    required this.totalAmount,
    required this.customerName,
    required this.theOrder,
    required this.shippingAddress,
  });

  Map<String, dynamic> toMap() {
    List<dynamic> orderListMap =
        theOrder.map((order) => order.toMap()).toList();

    return {
      'id': id,
      'date': date,
      'totalAmount': totalAmount,
      'customerName': customerName,
      'shippingAddress': shippingAddress,
      'theOrder': orderListMap,
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic>? map, String documentId) {
    List ordersData = map!['theOrder'] as List<dynamic>;
    List<AddToCartModel> ordersList = ordersData
        .map((item) => AddToCartModel.fromMap(item, documentId))
        .toList();

    return OrdersModel(
      id: documentId,
      date: map['date'] ?? '',
      totalAmount: map['totalAmount'] ?? 0.0,
      customerName: map['customerName'] ?? '',
      shippingAddress: map['shippingAddress'] ?? '',
      theOrder: ordersList,
    );
  }
}

// Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'date': date,
  //     'totalAmount': totalAmount,
  //     'customerName': customerName,
  //     'shippingAddress': shippingAddress,
  //     'theOrder': theOrder,
  //   };
  // }

// class OrdersModel {
//   final String id;
//   String date;
//   double totalAmount;
//   String customerName;
//   List<AddToCartModel> theOrder;
//   String shippingAddress;

//   OrdersModel({
//     required this.id,
//     required this.date,
//     required this.totalAmount,
//     required this.customerName,
//     required this.theOrder,
//     required this.shippingAddress,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'date': date,
//       'totalAmount': totalAmount,
//       'customerName': customerName,
//       'shippingAddress': shippingAddress,
//       'theOrder': theOrder,
//     };
//   }

//   factory OrdersModel.fromMap(Map<String, dynamic>? map, String documentId) {
//     List<Map<String, dynamic>> ordersData =
//         map!['theOrder'] as List<Map<String, dynamic>>;
//     List<AddToCartModel> ordersList = ordersData
//         .map((item) => AddToCartModel.fromMap(item, documentId))
//         .toList();

//     return OrdersModel(
//       id: documentId,
//       date: map!['date'] ?? '',
//       totalAmount: map['totalAmount'] ?? 0.0,
//       customerName: map['customerName'] ?? '',
//       shippingAddress: map['shippingAddress'] ?? '',
//       theOrder: ordersList,
//     );
//   }
// }
