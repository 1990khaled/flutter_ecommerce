import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/services/auth.dart';

class AuthController with ChangeNotifier {
  final AuthBase auth;
  String address;
  String imageUrl;
  String companyName;
  String phoneNumber;
  String otp;
  final database = FirestoreDatabase(
      '123'); // Replace '123' with your user ID or other appropriate identifier

  AuthController({
    required this.auth,
    this.imageUrl = '',
    this.address = '',
    this.companyName = '',
    this.phoneNumber = '',
    this.otp = '',
  });

  // Future<void> submitSignInWithPhone(
  //     BuildContext context, String phoneNumber) async {
  //   if (phoneNumber.isEmpty) {
  //     throw 'Phone number is required.';
  //   }

  //   try {
  //     await auth.signInWithPhoneNumber(context, phoneNumber);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future<void> submitSignInWithPhone(
  //     BuildContext context, String phoneNumber) async {
  //   if (phoneNumber.isEmpty) {
  //     throw 'Email and password are required.';
  //   }
  //   try {
  //     await auth.signInWithPhoneNumber(context, phoneNumber);
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  void updatePhone(String phoneNumber) {
    this.phoneNumber = phoneNumber;
    notifyListeners();
  }

  void updateImageUrl(String imageUrl) {
    this.imageUrl = imageUrl;
    notifyListeners();
  }

  void updateCompanyName(String companyName) {
    this.companyName = companyName;
    notifyListeners();
  }

  void updateAddress(String address) {
    this.address = address;
    notifyListeners();
  }

  void copyWith({
    String? address,
    String? imageUrl,
    String? companyName,
    String? phoneNumber,
  }) {
    this.address = address ?? this.address;
    this.imageUrl = imageUrl ?? this.imageUrl;
    this.companyName = companyName ?? this.companyName;
    this.phoneNumber = phoneNumber ?? this.phoneNumber;

    notifyListeners();
  }

  Future<void> logout() async {
    try {
      await auth.logout();
    } catch (e) {
      rethrow;
    }
  }
}
