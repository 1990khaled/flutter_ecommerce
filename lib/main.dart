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
  const MyApp({super.key});

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
              animationDuration: const Duration(seconds: 2),
              splash: Image.asset(
                "assets/images/al-yassin-group-SplashScre.png",
              ),
              nextScreen: const LandingPage()),
        ));
  }

//  --------------------------------------------------------------------------
  ThemeData themeMethod(BuildContext context) {
    CustomMaterialColor customMaterialColor =
        CustomMaterialColor(0, 27, 69, 118);
    return ThemeData(
      primaryColor: const Color(0xFF1B4571), // Adjusted primary color
      primarySwatch: customMaterialColor.mdColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1B4571), // Adjusted app bar color
        elevation: 2,
        iconTheme: IconThemeData(
          color: Colors.white,
          // Adjusted icon color
        ),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: const Color(0xFF1B4571), // Adjusted button color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        textTheme: ButtonTextTheme.accent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  4), // Adjust the border radius as needed
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return const Color(
                  0xFF1B4571); // Adjusted button color for ElevatedButton
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Colors.white70; // Adjusted text color for ElevatedButton
            },
          ),
        ),
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Color(0xFF1B4571),
      ),
      scaffoldBackgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(
            color: Color(0xFF1B4571), // Adjusted focused border color
          ),
        ),
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
      ),
    );
  }
}
