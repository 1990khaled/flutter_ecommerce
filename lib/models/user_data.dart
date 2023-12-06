class UserData {
  final String uid;
  final String email;

  UserData({required this.uid, required this.email});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'email': email});
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      uid: documentId,
      email: map['email'] ?? '',
    );
  }
}

//---------------------------------------------------------
class UserModel {
  String phoneNum;
  String profileImg;
  String name;
  String companyName;
  String address;
  String access;
  String id;

  UserModel({
    this.name = "name",
    this.phoneNum = "0000000000000",
    this.profileImg = "image",
    this.companyName = "companyName",
    this.address = "address",
    this.access = "user",
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNum': phoneNum,
      'profileImg': profileImg,
      'companyName': companyName,
      'address': address,
      'access': access,
      'id': id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      name: map['name'] ?? '', // handle nullability or default value here
      phoneNum: map['phoneNum'] ?? '',
      profileImg: map['profileImg'] ?? '',
      companyName: map['companyName'] ?? '',
      address: map['address'] ?? '',
      access: map['access'] ?? '',
      id: id,
    );
  }
}
