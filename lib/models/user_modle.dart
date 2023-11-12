
class UserModle {
  final String id;
  final String name;
  final int phoneNum;
  final String profileImg;
  final String companyName;
  final String adress;

  UserModle({
    required this.id,
    required this.name,
    required this.phoneNum,
    required this.profileImg,
    required this.companyName,
    required this.adress,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNum': phoneNum,
      'profileImg': profileImg,
      'companyName': companyName,
      'adress': adress,
      
    };
  }

  factory UserModle.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModle(
      id: documentId,
      name: map['name'] as String,
      phoneNum: map['phoneNum'] as int,
      profileImg: map['profileImg'] as String,
      companyName: map['companyName'] as String,
      adress: map['adress'] as String,
          );
  }
}
