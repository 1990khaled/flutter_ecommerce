import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/views/widgets/cart_list_item.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:flutter_ecommerce/views/widgets/order_summary_component.dart';
import 'package:provider/provider.dart';

import '../../models/orders_model.dart';
import '../../models/user_data.dart';
import 'add_user_information.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  double totalAmount = 1;
  int shippingCost = 50;
  double totalAmountPlusShip = 0;
  late List<UserModel> userModel;
  double calculateTotalAmountPlusShipping(
      double totalAmount, int shippingCost) {
    return totalAmount < 4000 ? totalAmount + shippingCost : totalAmount;
  }

  final database = Provider.of<Database>;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return SafeArea(
      child: StreamBuilder<List<AddToCartModel>>(
          stream: database.myProductsCart(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              // Handle error state
              return Center(
                child: Text(
                  'لا يوجد بيانات',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.active) {
              final cartItems = snapshot.data;
              // ... (previous calculations)

              double newTotalAmount = 0;
              if (cartItems != null && cartItems.isNotEmpty) {
                for (var element in cartItems) {
                  newTotalAmount +=
                      element.price * element.qunInCarton * element.quantity;
                }
              }
              totalAmount = newTotalAmount;
              totalAmountPlusShip =
                  calculateTotalAmountPlusShipping(totalAmount, shippingCost);
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // User information in a Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: FutureBuilder<UserModel?>(
                              future: database.getUserInformation(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    snapshot.hasData) {
                                  final userModle = snapshot.data!;
                                  return Text(userModle.name);
                                } else {
                                  return const Center(
                                    child: SizedBox(),
                                  );
                                }
                              },
                            ),
                          ),
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
                        ],
                      ),
//--------------------------------------------
//------------------------------------------------------
                      const SizedBox(height: 16.0),
                      if (cartItems == null || cartItems.isEmpty)
                        Center(
                          child: Text(
                            'لايوجد بيانات',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      if (cartItems != null && cartItems.isNotEmpty)
                        Column(
                          children: [
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
                            Column(
                              children: [
                                OrderSummaryComponent(
                                  value: "$totalAmountPlusShip ج",
                                  title: ' : اجمالي الحساب',
                                ),
                                const SizedBox(height: 8.0),
                                if (totalAmount < 4000)
                                  OrderSummaryComponent(
                                    value: "$shippingCost ج",
                                    title: ' : مصاريف الشحن',
                                  ),
                              ],
                            ),
                            const SizedBox(height: 32.0),
                            MainButton(
                              text: 'ارسال الطلبية',
                              onTap: () async {
                                final userModel =
                                    await database.getUserInformation();

                                if (userModel != null &&
                                    userModel.name != "name" &&
                                    userModel.address != "address") {
                                  final List<AddToCartModel>? cartItems =
                                      snapshot.data;
                                  if (cartItems != null) {
                                    OrdersModel order = OrdersModel(
                                      id: DateTime.now()
                                          .microsecondsSinceEpoch
                                          .toString(),
                                      date: DateTime.now().toString(),
                                      totalAmount: totalAmount,
                                      customerName: userModel.name,
                                      theOrder: cartItems,
                                      shippingAddress: userModel.address,
                                    );
                                    await database.addToMyOrders(
                                        order, order.id);
                                  }
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        const AddUserInfoFirstTime(),
                                  ));
                                }
                              },
                            ),
                            const SizedBox(height: 32.0),
                          ],
                        ),
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
