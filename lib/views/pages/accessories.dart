import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/views/widgets/header_of_list.dart';
import 'package:provider/provider.dart';

import '../widgets/list_item_accessori.dart';

class AccessoriesScreen extends StatelessWidget {
  const AccessoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 10, right: 10, top: 10),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onChanged: (value) {
                  // Perform search operation
                  // You can define your own logic here
                  print(value);
                },
              ),
            ),
            const HeaderOfList(
              title: '',
              description: 'اسعار الاكسسوار',
            ),
            const SizedBox(height: 4.0),
            SizedBox(
              height: size.height * 0.75,
              child: StreamBuilder<List<Product>>(
                  stream: database.salesProductsStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      final products = snapshot.data;
                      // debugPrint("$snapshot ----------------------");
                      if (products == null || products.isEmpty) {
                        return const Center(
                          child: Text('لا يوجد بيانات'),
                        );
                      }
                      return GridView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: products.length,
                        itemBuilder: (_, int index) => Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: ListItemAccessories(
                            product: products[index],
                          ),
                        ),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          ]),
        ),
      )),
    );
  }
}
