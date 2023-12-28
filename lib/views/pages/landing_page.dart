import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/auth_controller.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/services/auth.dart';
import 'package:flutter_ecommerce/views/pages/bottom_navbar.dart';
import 'package:provider/provider.dart';

import 'register_page.dart';
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context);

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          if (user == null) {
            return ChangeNotifierProvider<AuthController>(
              create: (_) => AuthController(auth: auth),
              child: const RegisterPage(),
            );
          } else {
            return MultiProvider( // Use MultiProvider for multiple providers
              providers: [
                ChangeNotifierProvider<AuthController>(
                  create: (_) => AuthController(auth: auth),
                ),
                Provider<Database>(
                  create: (_) => FirestoreDatabase(user.uid),
                ),
              ],
              child: const BottomNavbar(),
            );
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

// class LandingPage extends StatelessWidget {
//   const LandingPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final auth = Provider.of<AuthBase>(context);
    
//     return StreamBuilder<User?>(
//       stream: auth.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.active) {
//           final user = snapshot.data;
//           if (user == null) {
//             return ChangeNotifierProvider<AuthController>(
//               create: (_) => AuthController(auth: auth),
//               child: const RegisterPage(),
//             );
//           } else {
//             return ChangeNotifierProvider<AuthController>(
//               create: (_) => AuthController(auth: auth),
//               child: Provider<Database>(
//                 create: (_) => FirestoreDatabase(user.uid),
//                 child: const BottomNavbar(),
//               ),
//             );
//           }
//         }
//         return const Scaffold(
//           body: Center(
//             child: CircularProgressIndicator(),
//           ),
//         );
//       },
//     );
//   }
// }
