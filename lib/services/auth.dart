import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';


abstract class AuthBase {
  User? get currentUser;

  Stream<User?> authStateChanges();

  // Future<void> signInWithPhoneNumber(BuildContext context, String phoneNumber);

  // Future<void> signInAnonymously();

  Future<void> logout();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<void> logout() async => await _firebaseAuth.signOut();}
//--------------------------------------------------------------

  // @override
  // Future<void> signInWithPhoneNumber(
  //     BuildContext context, String phoneNumber) async {
  //   try {
  //     TextEditingController codeController = TextEditingController();
  //     await _firebaseAuth.verifyPhoneNumber(
  //         phoneNumber: phoneNumber,
  //         verificationCompleted: (PhoneAuthCredential credential) async {
  //           await _firebaseAuth.signInWithCredential(credential);
  //         },
  //         verificationFailed: (e) {
  //           showSnackbar(context, e.message!);
  //         },
  //         codeSent: ((String verificationId, int? resendToken) async {
  //           showOtpDialog(
  //             codeController: codeController,
  //             context: context,
  //             onPressed: () async {
  //               PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //                 verificationId: verificationId,
  //                 smsCode: codeController.text.trim(),
  //               );
  //               await _firebaseAuth
  //                   .signInWithCredential(credential)
  //                   .catchError((e) {
  //                 showSnackbar(
  //                     context, 'الكود غير صحيح، يرجى المحاولة مرة أخرى');
  //                 codeController.clear();
  //               }).whenComplete(() => Navigator.of(context).pop());
  //             },
  //           );
  //         }),
  //         codeAutoRetrievalTimeout: (String verificationId) {});
  //   } catch (e) {
  //     // ignore: use_build_context_synchronously
  //     showSnackbar(context, 'مشكلة بالاتصال');
  //   }
  // }
// }
//   @override
//   Future<void> signInAnonymously() async {
//     FirebaseAuth auth = FirebaseAuth.instance;

//     try {
//       UserCredential userCredential = await auth.signInAnonymously();
//       User? user = userCredential.user;

//       if (user != null) {
//         // The user is signed in anonymously
//         print('User signed in anonymously: ${user.uid}');
//       } else {
//         // Handle sign-in failure
//         print('Failed to sign in anonymously');
//       }
//     } catch (e) {
//       print('Error signing in anonymously: $e');
//     }
//   }
// }
