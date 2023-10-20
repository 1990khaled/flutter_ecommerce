class OfferModel {
  final String id;
   String typeOfAmmount;
   int? offeringPrice;
   int requiestAmmount;
   String actorName;
   String customerName;

  OfferModel({
    required this.id,
    required this.typeOfAmmount,
    required this.requiestAmmount,
    required this.customerName,
    this.offeringPrice,
    this.actorName = 'Other',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'typeOfAmmount': typeOfAmmount,
      'requiestAmmount': requiestAmmount,
      'customerName': customerName,
      'offeringPrice': offeringPrice,
      'actorName': actorName,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map, String documentId) {
    return OfferModel(
      id: documentId,
      typeOfAmmount: map['typeOfAmmount'] as String,
      requiestAmmount: map['requiestAmmount'] as int,
      customerName: map['customerName'] as String,
      offeringPrice: map['offeringPrice'] as int,
      actorName: map['actorName'] as String,
    );
  }
}
