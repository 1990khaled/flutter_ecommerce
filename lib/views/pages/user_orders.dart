import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/orders_model.dart';
import '../widgets/orders_info_list_item.dart';

class UserOrderPage extends StatefulWidget {
  final String customerName;
  const UserOrderPage({
    Key? key,
    required this.customerName,
  }) : super(key: key);

  @override
  State<UserOrderPage> createState() => _UserOrderPageState();
}

class _UserOrderPageState extends State<UserOrderPage> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("طلبياتي"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: StreamBuilder<List<OrdersModel>>(
        stream: database.myOrdersStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }

            final List<OrdersModel>? allOrders = snapshot.data;
            // Replace with the customer's name you want to filter

            if (allOrders == null || allOrders.isEmpty) {
              return Center(
                child: Text("لا يوجد طلبيات ${widget.customerName}"),
              );
            }

            final List<OrdersModel> customerOrders = allOrders
                .where((order) =>
                    order.customerName.toLowerCase() ==
                    widget.customerName.toLowerCase())
                .toList();

            if (customerOrders.isEmpty) {
              return Center(
                child: Text("لا يوجد طلبيات ${widget.customerName}"),
              );
            }

            return ListView.builder(
              itemCount: customerOrders.length,
              itemBuilder: (_, int index) => Padding(
                padding: const EdgeInsets.all(1.0),
                child: OrdersInfoListTime(
                  ordersModel: customerOrders[index],
                ),
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
