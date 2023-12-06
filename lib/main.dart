import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/services/auth.dart';
import 'package:flutter_ecommerce/utilities/router.dart';
import 'package:provider/provider.dart';

import 'controllers/auth_controller.dart';
import 'utilities/custom_material.dart';
import 'views/pages/landing_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<AuthBase>(
            create: (_) => Auth(),
          ),
          ListenableProvider<AuthController>(
            create: (context) => AuthController(
              auth: Provider.of<AuthBase>(context, listen: false),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeMethod(context),
          onGenerateRoute: onGenerate,
          // initialRoute:

          //  AppRoutes.landingPageRoute,

          home: AnimatedSplashScreen(
              animationDuration: const Duration(milliseconds: 3),
              splash: Image.asset(
                "assets/images/al-yassin-group-SplashScreen1.png",
              ),
              nextScreen: const LandingPage()),
        ));
  }

//  --------------------------------------------------------------------------
  ThemeData themeMethod(BuildContext context) {
    CustomMaterialColor customMaterialColor =
        CustomMaterialColor(0, 27, 69, 118);
    return ThemeData(
              primaryColorDark: const Color.fromARGB(0, 27, 69, 113),
        primarySwatch: customMaterialColor.mdColor,
        appBarTheme: const AppBarTheme(
          // backgroundColor: Colors.white,
          elevation: 2,
          iconTheme: IconThemeData(
            color: Color.fromARGB(0, 27, 69, 110),
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Color.fromARGB(0, 27, 69, 110),
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.accent,
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: Color.fromARGB(0, 27, 69, 110),
            ),
          ),
          // disabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(16.0),
          //   borderSide: const BorderSide(
          //     color: Color.fromARGB(0, 27, 69, 110),
          //   ),
          // ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(16.0),
          //   borderSide: const BorderSide(
          //     color: Color.fromARGB(0, 27, 69, 110),
          //   ),
          // ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
            borderSide: const BorderSide(
              color: Colors.red,
            ),
          ),
        ));
  }
}




//-----------------------------------
// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/services/auth.dart';
// import 'package:flutter_ecommerce/utilities/router.dart';
// import 'package:provider/provider.dart';

// import 'controllers/auth_controller.dart';
// import 'controllers/button_special_contrroler.dart';
// import 'utilities/custom_material.dart';
// import 'views/pages/landing_page.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           Provider<AuthBase>(
//             create: (_) => Auth(),
//           ),
//           ChangeNotifierProvider<SpecialController>(
//             create: (_) => SpecialController(),
//           ),
//           // ChangeNotifierProvider<LocalQuant>(create: (_) => LocalQuant()),
//           ChangeNotifierProvider(create: (_) => AuthController(auth: Provider.of<AuthBase>(context , listen: false),)),
//           Provider<AuthController>(
//             create: (context) =>
//                 AuthController(auth: Provider.of<AuthBase>(context ,listen: false),),
//           ),
//         ],
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: themeMethod(context),
//           onGenerateRoute: onGenerate,
//           // initialRoute:

//           //  AppRoutes.landingPageRoute,

//           home: AnimatedSplashScreen(
//               animationDuration: const Duration(milliseconds: 3),
//               splash: Image.asset(
//                 "assets/images/al-yassin-group-SplashScreen1.png",
//               ),
//               nextScreen: const LandingPage()),
//         ));
//   }

// //  --------------------------------------------------------------------------
//   ThemeData themeMethod(BuildContext context) {
//     CustomMaterialColor customMaterialColor =
//         CustomMaterialColor(0, 27, 69, 118);
//     return ThemeData(
//         scaffoldBackgroundColor: const Color.fromARGB(255, 236, 236, 236),
//         // primaryColor:const Color.fromARGB(0, 27, 69, 113),
//         primaryColorDark: const Color.fromARGB(0, 27, 69, 113),
//         primarySwatch: customMaterialColor.mdColor,
//         appBarTheme: const AppBarTheme(
//           // backgroundColor: Colors.white,
//           elevation: 2,
//           iconTheme: IconThemeData(
//             color: Color.fromARGB(0, 27, 69, 110),
//           ),
//         ),
//         buttonTheme: const ButtonThemeData(
//           buttonColor: Color.fromARGB(0, 27, 69, 110),
//           shape: RoundedRectangleBorder(),
//           textTheme: ButtonTextTheme.accent,
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           labelStyle: Theme.of(context).textTheme.bodyMedium,
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16.0),
//             borderSide: const BorderSide(
//               color: Color.fromARGB(0, 27, 69, 110),
//             ),
//           ),
//           // disabledBorder: OutlineInputBorder(
//           //   borderRadius: BorderRadius.circular(16.0),
//           //   borderSide: const BorderSide(
//           //     color: Color.fromARGB(0, 27, 69, 110),
//           //   ),
//           // ),
//           // enabledBorder: OutlineInputBorder(
//           //   borderRadius: BorderRadius.circular(16.0),
//           //   borderSide: const BorderSide(
//           //     color: Color.fromARGB(0, 27, 69, 110),
//           //   ),
//           // ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16.0),
//             borderSide: const BorderSide(
//               color: Colors.red,
//             ),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16.0),
//             borderSide: const BorderSide(
//               color: Colors.red,
//             ),
//           ),
//         ));
//   }
// }