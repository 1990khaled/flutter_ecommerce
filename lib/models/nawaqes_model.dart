// class NawaqesModel {
//   final String id;
//   final String title;
//   final int? offeringPrice;
//   final int requiestAmmount;
//   final String actorName;
//   final String customerName;

//   NawaqesModel({
//     required this.id,
//     required this.title,
//     required this.requiestAmmount,
//     required this.customerName,
//     this.offeringPrice,
//     this.actorName = 'Other',
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'requiestAmmount': requiestAmmount,
//       'customerName': customerName,
//       'offeringPrice': offeringPrice,
//       'actorName': actorName,
//     };
//   }

//   factory NawaqesModel.fromMap(Map<String, dynamic> map, String documentId) {
//     return NawaqesModel(
//       id: documentId,
//       title: map['title'] as String,
//       requiestAmmount: map['requiestAmmount'] as int,
//       customerName: map['customerName'] as String,
//       offeringPrice: map['offeringPrice'] as int,
//       actorName: map['actorName'] as String,
//     );
//   }
// }
