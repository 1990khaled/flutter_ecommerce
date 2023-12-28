// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/controllers/auth_controller.dart';
// import 'package:flutter_ecommerce/views/widgets/main_button.dart';
// import 'package:flutter_ecommerce/views/widgets/main_dialog.dart';
// import 'package:provider/provider.dart';

// class AuthPage extends StatefulWidget {
//   const AuthPage({Key? key}) : super(key: key);

//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
// //   Future<void> _submitOTP(AuthController model) async {
// //   try {
// //     await model.verifyPhoneNumberWithOTP(_verifyCodeController.text);
// //     if (!mounted) return;
// //   } catch (e) {
// //     MainDialog(
// //       context: context,
// //       title: 'Error Verification',
// //       content: e.toString(),
// //     ).showAlertDialog();
// //   }
// // }
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _verifyCodeController = TextEditingController();
//   final _emailFocusNode = FocusNode();
//   final _passwordFocusNode = FocusNode();
//   final _phoneFocusNode = FocusNode();
//   final _verifyCodeFocusNode = FocusNode();
//   bool loginPressed = false;
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _phoneController.dispose();
//     _verifyCodeController.dispose();
//     super.dispose();
//   }

//   Future<void> _submit(AuthController model) async {
//     try {
//       await model.submit();
//       if (!mounted) return;
//     } catch (e) {
//       MainDialog(
//               context: context,
//               title: 'Error Authentication',
//               content: e.toString())
//           .showAlertDialog();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final size = MediaQuery.of(context).size;

//     return Consumer<AuthController>(
//       builder: (_, model, __) {
//         return Scaffold(
//           resizeToAvoidBottomInset: true,
//           body: SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 60.0,
//                 horizontal: 32.0,
//               ),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Register',
//                         style: Theme.of(context).textTheme.headlineMedium,
//                       ),
//                       const SizedBox(height: 80.0),
//                       TextFormField(
//                         controller: _emailController,
//                         focusNode: _emailFocusNode,
//                         onEditingComplete: () => FocusScope.of(context)
//                             .requestFocus(_passwordFocusNode),
//                         textInputAction: TextInputAction.next,
//                         onChanged: model.updateEmail,
//                         validator: (val) =>
//                             val!.isEmpty ? 'Please enter your email!' : null,
//                         decoration: const InputDecoration(
//                           labelText: 'Email',
//                           hintText: 'Enter your email!',
//                         ),
//                       ),
//                       const SizedBox(height: 24.0),
//                       TextFormField(
//                         controller: _passwordController,
//                         focusNode: _passwordFocusNode,
//                         onEditingComplete: () => FocusScope.of(context)
//                             .requestFocus(_phoneFocusNode),
//                         validator: (val) =>
//                             val!.isEmpty ? 'Please enter your password!' : null,
//                         onChanged: model.updatePassword,
//                         obscureText: true,
//                         decoration: const InputDecoration(
//                           labelText: 'Password',
//                           hintText: 'Enter your pasword!',
//                         ),
//                       ),
//                       SizedBox(
//                         child: TextFormField(
//                           controller: _phoneController,
//                           focusNode: _phoneFocusNode,
//                           onEditingComplete: () => FocusScope.of(context)
//                               .requestFocus(_verifyCodeFocusNode),
//                           textInputAction: TextInputAction.next,
//                           onChanged: model.updatePhone,
//                           validator: (val) => val!.isEmpty
//                               ? 'Please enter your phone number!'
//                               : null,
//                           decoration: const InputDecoration(
//                             labelText: 'phone number',
//                             hintText: 'Enter your phone number!',
//                           ),
//                         ),
//                       ),
//                       if (loginPressed == true)
//                         SizedBox(
//                           child: TextFormField(
//                             controller: _verifyCodeController,
//                             focusNode: _verifyCodeFocusNode,
//                             onEditingComplete: () => FocusScope.of(context)
//                                 .requestFocus(_passwordFocusNode),
//                             textInputAction: TextInputAction.next,
//                             onChanged: model.updateOTP,
//                             validator: (val) => val!.isEmpty || val.length != 6
//                                 ? 'Please enter a valid 6-digit code!'
//                                 : null,
//                             decoration: const InputDecoration(
//                               labelText: 'Verify Code',
//                               hintText: 'Enter the verification code received',
//                             ),
//                           ),
//                         ),
//                       const SizedBox(height: 16.0),

//                       // Align(
//                       //   alignment: Alignment.topRight,
//                       //   child: InkWell(
//                       //     child: const Text('Forgot your password?'),
//                       //     onTap: () {},
//                       //   ),
//                       // ),
//                       const SizedBox(height: 24.0),
//                       MainButton(
//                         text: 'Register',
//                         onTap: () {
//                           setState(() {
//                             loginPressed = true;
//                           });
//                           if (_formKey.currentState!.validate()) {
//                             // If the form is for phone number login, submit OTP
//                             _submit(model);
//                             //------------------------------------
//                             // If the form is for email/password login or registration
//                             model.submit();
//                           }
//                         },
//                       ),

// //                       MainButton(
// //                         text: model.authFormType == AuthFormType.login
// //                             ? 'Login'
// //                             : 'Register',
// //                         onTap: () {
// //                           if (_formKey.currentState!.validate()) {
// // ///---------------------------------------

// //                             _submit(model);
// //                           }
// //                         },
// //                       ),
//                       const SizedBox(height: 16.0),
//                       Align(
//                         alignment: Alignment.center,
//                         child: InkWell(
//                           child: const Text(
//                             // ? 'Don\'t have an account? Register'
//                             'Have an account? Login',
//                           ),
//                           onTap: () {
//                             _formKey.currentState!.reset();
//                             // model.copyWith()
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
