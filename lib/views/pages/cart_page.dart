import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/views/widgets/cart_list_item.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:flutter_ecommerce/views/widgets/order_summary_component.dart';
import 'package:provider/provider.dart';

import '../../models/orders_model.dart';
import '../../models/user_modle.dart';
import 'edit_user_information.dart';

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
  late List<UserModle> userModel;
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
                            child: StreamBuilder<List<UserModle>>(
                              stream: database.profileInfoStream(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.active) {
                                  final userModel = snapshot.data;
                                  if (userModel == null || userModel.isEmpty) {
                                    return const Center(
                                      child: Text("لا يوجد بيانات"),
                                    );
                                  }
                                  final userData =
                                      userModel[0]; // Fetch first user data
                                  return Row(
                                    children: [
                                      Text(userData.name),
                                    ],
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
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
                                final List<AddToCartModel>? cartItems =
                                    snapshot.data;

                                final userModel =
                                    await database.profileInfoStream().first;
                                if (userModel.isEmpty) {
                                  navigatorKey.currentState
                                      ?.push(MaterialPageRoute(
                                    builder: (_) => const EditUserInformation(),
                                  ));
                                } else {
                                  OrdersModel order = OrdersModel(
                                    id: DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString(),
                                    date: DateTime.now().toString(),
                                    totalAmount: totalAmount,
                                    customerName: userModel[0].name,
                                    theOrder: cartItems ?? [],
                                    shippingAddress: userModel[0].adress,
                                  );
                                  // debugPrint(
                                  //     "${userModel[0].adress} ---------- $totalAmount --- ${cartItems![0].script}");
                                  await database.addToMyOrders(order, order.id);
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


// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/controllers/database_controller.dart';
// import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
// import 'package:flutter_ecommerce/views/widgets/cart_list_item.dart';
// import 'package:flutter_ecommerce/views/widgets/main_button.dart';
// import 'package:flutter_ecommerce/views/widgets/order_summary_component.dart';
// import 'package:provider/provider.dart';

// import '../../models/orders_model.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({Key? key}) : super(key: key);

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   double totalAmount = 1;
//   int shippingCost = 50;
//   double totalAmountPlusShip = 0;

//   double calculateTotalAmountPlusShipping(
//       double totalAmount, int shippingCost) {
//     return totalAmount < 4000 ? totalAmount + shippingCost : totalAmount;
//   }

//   final database = Provider.of<Database>;

//   @override
//   Widget build(BuildContext context) {
//     final database = Provider.of<Database>(context);

//     return SafeArea(
//       child: StreamBuilder<List<AddToCartModel>>(
//           stream: database.myProductsCart(),
//           builder: (context, snapshot) {
           
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   'لايوجد بيانات',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//               );
//             }
//             if (snapshot.connectionState == ConnectionState.active) {
//               final cartItems = snapshot.data;
//               double newTotalAmount = 0;
//               if (cartItems != null && cartItems.isNotEmpty) {
//                 for (var element in cartItems) {
//                   newTotalAmount +=
//                       element.price * element.qunInCarton * element.quantity;
//                 }
//               }
//               totalAmount = newTotalAmount;
//               totalAmountPlusShip =
//                   calculateTotalAmountPlusShipping(totalAmount, shippingCost);

//               return SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 8.0, horizontal: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       const SizedBox(height: 16.0),
//                       Text(
//                         'الطلبيات',
//                         textAlign: TextAlign.right,
//                         style: Theme.of(context)
//                             .textTheme
//                             .headlineMedium!
//                             .copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       if (cartItems == null || cartItems.isEmpty)
//                         Center(
//                           child: Text(
//                             'لايوجد بيانات',
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                         ),
//                       if (cartItems != null && cartItems.isNotEmpty)
//                         Column(
//                           children: [
//                             ListView.builder(
//                               itemCount: cartItems.length,
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemBuilder: (BuildContext context, int i) {
//                                 final cartItem = cartItems[i];
//                                 return CartListItem(
//                                   cartItem: cartItem,
//                                 );
//                               },
//                             ),
//                             const SizedBox(height: 24.0),
//                             Column(
//                               children: [
//                                 OrderSummaryComponent(
//                                   value: "$totalAmount",
//                                   title: ' : اجمالي الطلبية',
//                                 ),
//                                 const SizedBox(height: 8.0),
//                                 if (totalAmount < 4000)
//                                   OrderSummaryComponent(
//                                     value: "$shippingCost ج",
//                                     title: ' : مصاريف الشحن',
//                                   ),
//                                 const SizedBox(height: 8.0),
//                                 OrderSummaryComponent(
//                                   value: "$totalAmountPlusShip ج",
//                                   title: ' : اجمالي الحساب',
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(height: 32.0),
//                             MainButton(
//                               text: 'ارسال الطلبية',
//                               onTap: () async {

//                                  final List<AddToCartModel>? cartItems = snapshot.data;
//             OrdersModel order = OrdersModel(
//               id: DateTime.now()
//                   .microsecondsSinceEpoch
//                   .toString(), // You need a unique identifier for the order
//               date: DateTime.now()
//                   .toString(), // You can use the current date/time
//               totalAmount: totalAmount, // Total amount from cart items
//               customerName:
//                   'Customer Name', // Replace with actual customer name
//               theOrder: cartItems ?? [], // List of cart items
//               shippingAddress:
//                   'Shipping Address', 
//                   // Replace with actual address
//             );
            
//                                 await database.addToMyOrders(order);
//                                 // await database.addToUserOrders(order);
//                               },
//                             ),
//                             const SizedBox(height: 32.0),
//                           ],
//                         ),
//                     ],
//                   ),
//                 ),
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//     );
//   }
// }
