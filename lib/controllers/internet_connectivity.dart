// import 'package:flutter/material.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// class InternetCheckingController with ChangeNotifier {
//   bool isConnected;

//   InternetCheckingController({
//     this.isConnected = true,
//   });

//   void copyWith({
//     bool? isConnected,
//   }) {
//     this.isConnected = isConnected ?? this.isConnected;
//     notifyListeners();
//   }

//   Future<bool> internetConnectionResult() async {
//     bool result = await InternetConnectionChecker().hasConnection;
//     isConnected = result; // Update the isConnected property
//     notifyListeners();
//     return result;
//   }
// }
