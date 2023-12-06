import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/orders_model.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../pages/company/order_details.dart';

class OrdersInfoListTime extends StatelessWidget {
  final OrdersModel ordersModel;
  const OrdersInfoListTime({super.key, required this.ordersModel});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            child: ListTile(
              title: Text(ordersModel.customerName),
              subtitle: Text(ordersModel.date),
              leading: IconButton(
                  onPressed: () {
                    database.deleteOrder(ordersModel);
                  },
                  icon: const Icon(Icons.delete)),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OrderDetailsPage(
                              orderId: ordersModel.id,
                            )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
//   void deleting() {
//     database.
//   }
// }
