// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'orders_model.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// OrdersModel _$OrdersModelFromJson(
//         Map<String, dynamic> json, String documentId) =>
//     OrdersModel(
//       id: json['id'] as String,
//       date: json['date'] as String,
//       totalAmount: (json['totalAmount'] as num).toDouble(),
//       customerName: json['customerName'] as String,
//       shippingAddress: json['shippingAddress'] as String,
//       theOrder: (json['theOrder'] as List<Map<String, dynamic>>)
//           .map((item) => AddToCartModel.fromMap(item, documentId))
//           .toList(),
//     );

// Map<String, dynamic> _$OrdersModelToJson(OrdersModel instance) =>
//     <String, dynamic>{
//       'id': instance.id,
//       'date': instance.date,
//       'totalAmount': instance.totalAmount,
//       'customerName': instance.customerName,
//       'shippingAddress': instance.shippingAddress,
//       'theOrder': instance.theOrder,
//     };
