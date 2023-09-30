import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/utilities/args_models/add_shipping_address_args.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:flutter_ecommerce/views/pages/auth_page.dart';
import 'package:flutter_ecommerce/views/pages/bottom_navbar.dart';
import 'package:flutter_ecommerce/views/pages/checkout/add_shipping_address_page.dart';
import 'package:flutter_ecommerce/views/pages/checkout/checkout_page.dart';
import 'package:flutter_ecommerce/views/pages/checkout/shipping_addresses_page.dart';
import 'package:flutter_ecommerce/views/pages/landing_page.dart';
import 'package:flutter_ecommerce/views/pages/product_details.dart';
import 'package:provider/provider.dart';
import '../views/pages/add_nawaqes.dart';
import '../views/pages/add_offer.dart';
import '../views/pages/nawaqes_details.dart';

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
    //-----------------------------------
    case AppRoutes.checkoutPageRoute:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
            value: database, child: const CheckoutPage()),
        settings: settings,
      );
    //-----------------------------------
    case AppRoutes.productDetailsRoute:
      final args = settings.arguments as Map<String, dynamic>;
      final product = args['product'];
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: ProductDetails(product: product),
        ),
        settings: settings,
      );
    //-----------------------------------
    case AppRoutes.nawaqesDetailsRoute:
      final args = settings.arguments as Map<String, dynamic>;
      final nawaqes = args['nawaqes'];
      final database = args['database'];
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: NawaqestDetails(nawaqes: nawaqes),
        ),
        settings: settings,
      );
    //-----------------------------------
    case AppRoutes.shippingAddressesRoute:
      final database = settings.arguments as Database;
      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: const ShippingAddressesPage(),
        ),
        settings: settings,
      );
//-----------------------------------
    case AppRoutes.addOfferRout:
      return CupertinoPageRoute(
        builder: (_) => AddOfferpage(),
        settings: settings,
      );
//-----------------------------------
    case AppRoutes.addNawaqesRout:
      return MaterialPageRoute(
        builder: (_) => AddNawaqespage(),
        settings: settings,
      );
//-----------------------------------
    case AppRoutes.addShippingAddressRoute:
      final args = settings.arguments as AddShippingAddressArgs;
      final database = args.database;
      final shippingAddress = args.shippingAddress;

      return CupertinoPageRoute(
        builder: (_) => Provider<Database>.value(
          value: database,
          child: AddShippingAddressPage(
            shippingAddress: shippingAddress,
          ),
        ),
        settings: settings,
      );
    //-----------------------------------
    case AppRoutes.landingPageRoute:
    default:
      return CupertinoPageRoute(
        builder: (_) => const LandingPage(),
        settings: settings,
      );
  }
}
