class UserData {
  final String uid;
  final String phoneNumber;
  final String role;

  UserData({
    required this.uid,
    required this.phoneNumber,
    required this.role
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'uid': uid});
    result.addAll({'phoneNumber': phoneNumber});
result.addAll({'role': role});
    return result;
  }

  factory UserData.fromMap(Map<String, dynamic> map, String documentId) {
    return UserData(
      uid: documentId,
      phoneNumber: map['phoneNumber'] ?? '',
       role: map['role'] ?? '',
    );
  }
}

//---------------------------------------------------------
class UserModel {
  String phoneNum;
  String profileImg;
  String companyName;
  String address;
  String access;
  String id;

  UserModel({
    this.phoneNum = "0000000000000",
    this.profileImg = "image",
    this.companyName = "companyName",
    this.address = "address",
    this.access = "user",
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
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
      // handle nullability or default value here
      phoneNum: map['phoneNum'] ?? '',
      profileImg: map['profileImg'] ?? '',
      companyName: map['companyName'] ?? '',
      address: map['address'] ?? '',
      access: map['access'] ?? '',
      id: id,
    );
  }
}
