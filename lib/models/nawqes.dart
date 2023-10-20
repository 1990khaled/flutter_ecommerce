class ShowingNawaqesModel {
  final String id;
    String title;
    int price;
    int ammount;
    String description;
    String actorName;

  ShowingNawaqesModel(
      {required this.id,
      required this.title,
      required this.description,
      this.price = 0,
      required this.actorName ,
      required this.ammount});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'ammount': ammount,
      'actorName': actorName,
    };
  }

  factory ShowingNawaqesModel.fromMap(
      Map<String, dynamic> map, String documentId) {
    return ShowingNawaqesModel(
      id: documentId,
      title: map['title'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      ammount: map['ammount'] as int,
      actorName: map['actorName'] as String,
    );
  }
}
