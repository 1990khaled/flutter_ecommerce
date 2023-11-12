import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/views/widgets/cart_list_item.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:flutter_ecommerce/views/widgets/order_summary_component.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);


  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalAmount = 0;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    final myProducts = await Provider.of<Database>(context, listen: false)
        .myProductsCart()
        .first;
    for (var element in myProducts) {
      setState(() {
        totalAmount += element.price;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return SafeArea(
      child: StreamBuilder<List<AddToCartModel>>(
          stream: database.myProductsCart(),
          builder: (context, snapshot) {
            //TODO deleeting snapshothas error
            if (snapshot.hasError) {
              Center(
                child: Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              final cartItems = snapshot.data;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                      const SizedBox(height: 16.0),
                      Text(
                        'الطلبيات',
                        textAlign : TextAlign.right,
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
                            '${snapshot.error}',
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
                            );
                          },
                        ),
                      const SizedBox(height: 24.0),
                      OrderSummaryComponent(
                        value: "7.0" ,
                        title: ' :اجمالي الحساب',
                        
                      ),
                      const SizedBox(height: 32.0),
                      MainButton(
                        text: 'ارسال الطلبية',
                        onTap: () {}
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
