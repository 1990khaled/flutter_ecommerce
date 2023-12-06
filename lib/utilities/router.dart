import 'package:flutter/cupertino.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/pages/auth_page.dart';
import 'package:flutter_ecommerce/views/pages/bottom_navbar.dart';
import 'package:flutter_ecommerce/views/pages/favorite.dart';
import 'package:flutter_ecommerce/views/pages/landing_page.dart';
import 'package:flutter_ecommerce/views/pages/product_details.dart';
import 'package:provider/provider.dart';
import '../views/pages/editing/add_new_product.dart';
import '../views/pages/new_product_details.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.loginPageRoute:
      return CupertinoPageRoute(
        builder: (_) => const AuthPage(),
        settings: settings,
      );
    //-----------------------------------
    case AppRoutes.bottomNavBarRoute:
      return CupertinoPageRoute(
        builder: (_) => const BottomNavbar(),
        settings: settings,
      );
    // //-----------------------------------
    // case AppRoutes.checkoutPageRoute:
    //   final database = settings.arguments as Database;
    //   return CupertinoPageRoute(
    //     builder: (_) => Provider<Database>.value(
    //         value: database, child: const CheckoutPage()),
    //     settings: settings,
    //   );
    //-----------------------------------
    case AppRoutes.productDetailsRoute:
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: NewProductDetails(product: product),
        ),
        settings: settings,
      );
// ------------------------------------------------------------
    case AppRoutes.favourite:
      final args = settings.arguments as Map<String, dynamic>;
      // final product = args['product'];
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: const Favorite(),
        ),
        settings: settings,
      );
// ------------------------------------------------------------
    case AppRoutes.newproductDetailsRoute:
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: ProductDetails(newProduct: product),
        ),
        settings: settings,
      );
    //-----------------------------------
   
    // //-----------------------------------
    // case AppRoutes.shippingAddressesRoute:
    //   final database = settings.arguments as Database;
    //   return CupertinoPageRoute(
    //     builder: (_) => Provider<Database>.value(
    //       value: database,
    //       child: const ShippingAddressesPage(),
    //     ),
    //     settings: settings,
    //   );
//-----------------------------------
    case AppRoutes.addNewProductPage:
      final args = settings.arguments as Map<String, dynamic>;
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: const AddNewProductPage(),
        ),
        settings: settings,
      );
//-----------------------------------
    // case AppRoutes.addProduct:
    //  final args = settings.arguments as Map<String, dynamic>;
    //   final database = args['database'];
    //   return MaterialPageRoute(
    //      builder: (_) => Provider<Database>.value(
    //       value: database,
    //       child: const AddNewProductPage(),
    //     ),
    //     settings: settings,
    //   );
//-----------------------------------
    // case AppRoutes.addShippingAddressRoute:
    //   final args = settings.arguments as AddShippingAddressArgs;
    //   final database = args.database;
    //   final shippingAddress = args.shippingAddress;

    //   return CupertinoPageRoute(
    //     builder: (_) => Provider<Database>.value(
    //       value: database,
    //       child: AddShippingAddressPage(
    //         shippingAddress: shippingAddress,
    //       ),
    //     ),
    //     settings: settings,
    //   );
    //-----------------------------------
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
        settings: settings,
      );
  }
}
