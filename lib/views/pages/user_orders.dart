import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/orders_model.dart';
import '../widgets/orders_info_list_item.dart';

class UserOrderPage extends StatefulWidget {
  final String companyName;
  final String phoneNum;

  const UserOrderPage({
    super.key,
    required this.companyName,
    required this.phoneNum,
  });

  @override
  State<UserOrderPage> createState() => _UserOrderPageState();
}

class _UserOrderPageState extends State<UserOrderPage> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("طلبياتي"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<List<OrdersModel>>(
          stream: database.myOrdersStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text("يوجد مشكلة بالاتصال"),
                );
              }

              final List<OrdersModel>? allOrders = snapshot.data;

              if (allOrders == null || allOrders.isEmpty) {
                return const Center(
                  child: Text("لا يوجد طلبيات"),
                );
              }

              final List<OrdersModel> customerOrders = allOrders
                  .where((order) =>
                      order.customerName.toLowerCase() ==
                      widget.companyName.toLowerCase())
                  .toList();

              if (customerOrders.isEmpty) {
                return Center(
                  child: Text("لا يوجد طلبيات ${widget.companyName}"),
                );
              }

              return ListView.builder(
                itemCount: customerOrders.length,
                itemBuilder: (_, int index) => Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: OrdersInfoListTime(
                    ordersModel: customerOrders[index],
                    phoneNum: widget.phoneNum,
                    index: index,
                  ),
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}


// class UserOrderPage extends StatefulWidget {
//   final String companyName;
//   final String phoneNum;
//   const UserOrderPage({
//     Key? key,
//     required this.companyName,
//     required this.phoneNum,
//   }) : super(key: key);

//   @override
//   State<UserOrderPage> createState() => _UserOrderPageState();
// }

// class _UserOrderPageState extends State<UserOrderPage> {
//   @override
//   Widget build(BuildContext context) {
//     // final size = MediaQuery.of(context).size;
//     final database = Provider.of<Database>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("طلبياتي"),
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () => Navigator.of(context).pop(),
//           icon: const Icon(Icons.arrow_back),
//           color: Colors.white,
//         ),
//       ),
//       body: SafeArea(
//           child: StreamBuilder<List<OrdersModel>>(
//         stream: database.myOrdersStream(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.hasError) {
//               return const Center(
//                 child: Text("يوجد مشكلة بالاتصال"),
//               );
//             }

//             final List<OrdersModel>? allOrders = snapshot.data;
//             // Replace with the customer's name you want to filter

//             if (allOrders == null || allOrders.isEmpty) {
//               return const Center(
//                 child: Text("لا يوجد طلبيات"),
//               );
//             }

//             final List<OrdersModel> customerOrders = allOrders
//                 .where((order) =>
//                     order.customerName.toLowerCase() ==
//                     widget.companyName.toLowerCase())
//                 .toList();

//             if (customerOrders.isEmpty) {
//               return Center(
//                 child: Text("لا يوجد طلبيات ${widget.companyName}"),
//               );
//             }

//             return ListView.builder(
//               itemCount: customerOrders.length,
//               itemBuilder: (_, int index) => Padding(
//                 padding: const EdgeInsets.all(1.0),
//                 child: OrdersInfoListTime(
//                   ordersModel: customerOrders[index],
//                   phoneNum: widget.phoneNum,
//                   index: index,
//                 ),
//               ),
//             );
//           }

//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       )),
//     );
//   }
// }
