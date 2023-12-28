import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/orders_model.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../pages/company/order_details.dart';

class AllOrdersListInformation extends StatelessWidget {
  final OrdersModel ordersModel;
  final String phoneNum;
  final int index;
  const AllOrdersListInformation(
      {super.key,
      required this.ordersModel,
      required this.phoneNum,
      required this.index});

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Card(
              color: const Color.fromARGB(255, 221, 221, 231),
              child: ListTile(
                title: Text(ordersModel.customerName),
                subtitle: Text(ordersModel.date),
                leading: Text("${index + 1}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: const Color.fromARGB(255, 0, 0, 0),
                        )),
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      actions: [
                        PopupMenuItem(
                          child: ListTile(
                              leading: const Icon(Icons.add),
                              title: const Text('حذف '),
                              onTap: () async {
                                await database.deleteOrder(ordersModel);
                              }),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.add),
                            title: const Text('رجوع '),
                            onTap: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OrderDetailsPage(
                                orderId: ordersModel.id,
                                phoneNum: phoneNum,
                              )));
                },
              ),
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
