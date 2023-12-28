import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../widgets/main_button.dart';
import 'landing_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _firebaseAuth = FirebaseAuth.instance;
  final _phoneNumberController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _submitSignInWithPhone(BuildContext context) async {
    final String phoneNumber = '+2${_phoneNumberController.text}';
    if (phoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('من فضلك ادخل رقم الهاتف 11 رقما',
                textAlign: TextAlign.center)),
      );
      return;
    }

    try {
      await signInWithPhoneNumber(context, phoneNumber);
    } catch (e) {
      debugPrint(e.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'مشكلة بالتسجيل حاول مرة اخرى.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  Future<void> signInWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
          // Navigate to the landing page or perform any necessary actions upon successful verification
        },
        verificationFailed: (FirebaseAuthException e) {
          showErrorMessage(context, e.code);
        },
        codeSent: (String verificationId, int? resendToken) {
          showOtpDialog(context, verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showErrorMessage(context, 'مشكلة بالتسجيل');
    }
  }

  void showErrorMessage(BuildContext context, String errorMessage) {
    String messageToShow = 'مشكلة بالتسجيل';

    // Customize messages based on specific error codes if required
    switch (errorMessage) {
      case 'invalid-phone-number':
        messageToShow = 'رقم الهاتف غير صحيح';
        break;
      case 'too-many-requests':
        messageToShow = ' لقد تم ارسال الكثير من الطلبات حاول وقت لاحق';
        break;
      // Handle other error cases if needed
      default:
        messageToShow = 'مشكلة بالتسجيل';
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
        messageToShow,
        textAlign: TextAlign.center,
      )),
    );
  }

  void showOtpDialog(BuildContext context, String verificationId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          "من فضلك ادخل الكود بالأرقام الإنجليزية",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        content: TextField(
          textAlign: TextAlign.center,
          controller: _codeController,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final code = _codeController.text.trim();
              if (code.isNotEmpty || _codeController.text.length != 6) {
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: verificationId,
                  smsCode: code,
                );
                try {
                  await _firebaseAuth
                      .signInWithCredential(credential)
                      .whenComplete(() => Navigator.of(context).pop());
                } catch (e) {
                  // ignore: use_build_context_synchronously
                  showErrorMessage(context,
                      'الكود غير صحيح تأكد انه من 6 ارقام بالانجليزية');
                  _codeController.clear();
                  return;
                }
              }
            },
            child: const Text("موافق"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/al-egyptianTalbackgroundApp.png",
                width: double.infinity,
                height: size.height * 0.275,
                fit: BoxFit.cover,
              ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 12.0,
                ),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "تسجيل الدخول",
                      // textAlign: TextAlign.right,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 3, 58, 102),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          controller: _phoneNumberController,
                          validator: (val) =>
                              val!.isEmpty ? 'من فضلك ادخل رقم الموبايل' : null,
                          // onChanged: model.updatePhone,
                          decoration: const InputDecoration(
                            counterStyle: TextStyle(fontSize: 20),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            labelStyle: TextStyle(
                              fontSize: 16,
                            ),
                            labelText: 'رقم موبايل من 11 رقما',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1),
                  SmallMainButton(
                    onTap: () async {
                      bool result =
                          await InternetConnectionChecker().hasConnection;
                      try {
                        String phoneNumber = '+2${_phoneNumberController.text}';
                        if (phoneNumber.isNotEmpty && result == true) {
                          if (_phoneNumberController.text.length != 11) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'رقم الهاتف يجب أن يكون 11 رقمًا',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          } else {
                            // ignore: use_build_context_synchronously
                            await _submitSignInWithPhone(context).whenComplete(
                              () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const LandingPage(),
                              )),
                            );
                          }
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'ربما رقم الهاتف غير صحيح او الاتصال بالانترنت مفقود',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'خطأ عند التسجيل، يرجى المحاولة مرة أخرى',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    text: "ارسال",
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
