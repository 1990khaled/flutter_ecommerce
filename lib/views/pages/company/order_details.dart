import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/orders_model.dart';
import 'package:flutter_ecommerce/views/widgets/order_list_item.dart';
import 'package:provider/provider.dart';

import '../../../models/add_to_cart_model.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;
  const OrderDetailsPage({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

    return SafeArea(
      child: StreamBuilder<List<OrdersModel>>(
        stream: database.myOrdersStream(),
        builder: (context, snapshot) {
          var order = snapshot.data;
          if (snapshot.hasError) {
            debugPrint("${snapshot.error}");
            return Center(
              child: Text(
                "${snapshot.error}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final orderDetails = snapshot.data?.firstWhere(
              (order) => order.id == widget.orderId,
              orElse: () => order![0]);

          if (orderDetails == null) {
            return Center(
              child: Text(
                'Order details not found!',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    'اسم العميل: ${orderDetails.customerName}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),

                  Text(
                    'عنوان الشحن: ${orderDetails.shippingAddress}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 16.0),
                  ListView.builder(
                    itemCount: orderDetails.theOrder.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int itIndex) {
                      final AddToCartModel cartItem =
                          orderDetails.theOrder[itIndex];
                      return OrderListItem(cartItem: cartItem);
                    },
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    'اجمالي الحساب : ${orderDetails.totalAmount}',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  // Other components or summary can be added here if needed
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/controllers/database_controller.dart';
// import 'package:flutter_ecommerce/views/widgets/order_summary_component.dart';
// import 'package:provider/provider.dart';

// import '../../../models/add_to_cart_model.dart';
// import '../../../models/orders_model.dart';
// import '../../widgets/order_list_item.dart';

// class OrderDetailsPage extends StatefulWidget {
//   const OrderDetailsPage({Key? key, required String orderId}) : super(key: key);

//   @override
//   State<OrderDetailsPage> createState() => _OrderDetailsPageState();
// }

// class _OrderDetailsPageState extends State<OrderDetailsPage> {
//   List<OrdersModel>? newData;
//   int index = 0; // Initialize the index

//   @override
//   Widget build(BuildContext context) {
//     final database = Provider.of<Database>(context);

//     return SafeArea(
//       child: StreamBuilder<List<OrdersModel>>(
//         stream: database.myOrdersStream(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             debugPrint(
//               "${snapshot.error}",
//             );
//             return Center(
//               child: Text(
//                 // 'لايوجد بيانات',
//                 "${snapshot.error}",

//                 textAlign: TextAlign.center,
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             );
//           }

//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           newData = snapshot.data;
//           if (newData == null || newData!.isEmpty) {
//             return Center(
//               child: Text(
//                 'لايوجد بيانات',
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//             );
//           }

//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 8.0,
//                 horizontal: 16.0,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   const SizedBox(height: 16.0),
//                   Text(
//                     'اسم العميل : ${newData![index].customerName}',
//                     textAlign: TextAlign.right,
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                         ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   Text(
//                     'عنوان الشحن : ${newData![index].shippingAddress}',
//                     textAlign: TextAlign.right,
//                     style: Theme.of(context).textTheme.titleSmall,
//                   ),
//                   const SizedBox(height: 16.0),
//                   Column(
//                     children: [
//                       //  ListView.builder(
//                       //   itemCount: newData!.length,
//                       //   shrinkWrap: true,
//                       //   physics: const NeverScrollableScrollPhysics(),
//                       //   itemBuilder: (BuildContext context, int i) {
//                       //     final cartItem = newData![i].theOrder;
//                       //     return OrderListItem(
//                       //       cartItem: cartItem[i],
//                       //     );
//                       //   },
//                       // ),
//                       ListView.builder(
//                         itemCount: newData![index].theOrder.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemBuilder: (BuildContext context, int i) {
//                           final AddToCartModel cartItem =
//                               newData![index].theOrder[i];
//                           return OrderListItem(
//                             cartItem: cartItem,
//                           );
//                         },
//                       ),
//                       const SizedBox(height: 24.0),
//                       OrderSummaryComponent(
//                         value: "${newData![index].totalAmount}",
//                         title: ' : اجمالي الطلبية',
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
