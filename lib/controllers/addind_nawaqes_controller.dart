// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/controllers/database_controller.dart';
// import '../models/nawaqes_model.dart';

// class AddingNawaqesController with ChangeNotifier {
//   // final AuthBase auth;
//   final NawaqesModel nawaqesModel =
//       NawaqesModel(customerName: '', id: '', title: '', requiestAmmount: 0);
//   // AuthFormType authFormType;
//   // // TODO: It's not a best practice thing but it's temporary
//   final database = FirestoreDatabase("flutter");
//   AddingNawaqesController({
//     nawaqesModel,
//   });

//   Future<void> submit() async {
//     try {
//       (Map<String, dynamic> map, String documentId) {
//         NawaqesModel(
//           id: documentId,
//           title: map['title'] as String,
//           requiestAmmount: map['requiestAmmount'] as int,
//           customerName: map['customerName'] as String,
//           offeringPrice: map['offeringPrice'] as int,
//           actorName: map['actorName'] as String,
//         );
//       };
//     } catch (e) {
//       rethrow;
//     }
//   }
// }



//   // void toggleFormType() {
//   //   final formType = authFormType == AuthFormType.login
//   //       ? AuthFormType.register
//   //       : AuthFormType.login;
//   //   copyWith(
//   //     email: '',
//   //     password: '',
//   //     authFormType: formType,
//   //   );
//   // }

//   // void updateEmail(String email) => copyWith(email: email);

//   // void updatePassword(String password) => copyWith(password: password);

//   // void copyWith({
//   //   String? email,
//   //   String? password,
//   //   AuthFormType? authFormType,
//   // }) {
//   //   this.email = email ?? this.email;
//   //   this.password = password ?? this.password;
//   //   this.authFormType = authFormType ?? this.authFormType;
//   //   notifyListeners();
//   // }

//   // Future<void> logout() async {
//   //   try {
//   //     await auth.logout();
//   //   } catch (e) {
//   //     rethrow;
//   //   }
//   // }
// // }
