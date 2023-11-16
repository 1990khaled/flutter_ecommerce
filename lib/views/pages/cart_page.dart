import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/views/widgets/cart_list_item.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:flutter_ecommerce/views/widgets/order_summary_component.dart';
import 'package:provider/provider.dart';
import '../../controllers/button_special_contrroler.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  var specialController = Provider.of<SpecialController>;
  double totalAmount = 1;
  final database = Provider.of<Database>;

   @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final myProducts = await Provider.of<Database>(context, listen: false)
        .myProductsCart()
        .first;

    double newTotalAmount = 0;

    for (var element in myProducts) {
      newTotalAmount +=
          element.price * element.qunInCarton * element.quantity;
    }

    setState(() {
      totalAmount = newTotalAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return SafeArea(
      child: StreamBuilder<List<AddToCartModel>>(
          stream: database.myProductsCart(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Center(
                child: Text(
                  'لايوجد بيانات',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              final cartItems = snapshot.data;
                 double newTotalAmount = 0;
                 if (cartItems != null && cartItems.isNotEmpty) {
              for (var element in cartItems) {
                newTotalAmount +=
                    element.price * element.qunInCarton * element.quantity;
              }
            }

            totalAmount = newTotalAmount;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        'الطلبيات',
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      if (cartItems == null || cartItems.isEmpty)
                        Center(
                          child: Text(
                            'لايوجد بيانات',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      if (cartItems != null && cartItems.isNotEmpty)
                        ListView.builder(
                          itemCount: cartItems.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            final cartItem = cartItems[i];
                            return CartListItem(
                              cartItem: cartItem,
                              // localQuantity: ,
                            );
                          },
                        ),
                      const SizedBox(height: 24.0),
                      OrderSummaryComponent(
                        value: "$totalAmount",
                        title: 'اجمالي الحساب',
                      ),
                      const SizedBox(height: 32.0),
                      MainButton(text: 'ارسال الطلبية', onTap: () {}
                          // => Navigator.of(context, rootNavigator: true)
                          //     .pushNamed(
                          //   AppRoutes.checkoutPageRoute,
                          //   arguments: database,
                          // ),
                          // hasCircularBorder: true,
                          ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
