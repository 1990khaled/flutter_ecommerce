import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:internet_connectivity_checker/internet_connectivity_checker.dart';
import 'package:provider/provider.dart';

import '../widgets/list_item_accessori.dart';

class AccessoriesScreen extends StatefulWidget {
  const AccessoriesScreen({super.key});

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String value = searchController.text;
    // bool isSearching;
    // final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              FocusScope.of(context).unfocus();
              searchController.clear();
              setState(() {
                value = "";
              });
            },
          ),
        ),
        flexibleSpace: Container(),
        title: TextField(
          textAlign: TextAlign.end,
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: ' بحث ... ',
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {
                  // setState(() {
                  //   isSearching = true;
                  // });
                },
              ),
            ),
          ),
          onChanged: (newValue) {
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            left: 10,
            right: 10,
            top: 35,
          ),
          child: StreamBuilder<List<Product>>(
            stream: database.salesProductsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final products = snapshot.data
                    ?.where((element) => element.title
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .where((element) => element.category != '0')
                    .toList();

                if (products == null || products.isEmpty || snapshot.hasError) {
                  return const Center(
                    child: Text("لا يوجد بيانات"),
                  );
                }

                products.sort((a, b) => a.title.compareTo(b.title));

                return StreamBuilder<bool>(
                  stream:
                      ConnectivityChecker(interval: const Duration(seconds: 10))
                          .stream,
                  builder: (context, connectivitySnapshot) {
                    if (connectivitySnapshot.hasData &&
                        connectivitySnapshot.data == true) {
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
                    } else if (connectivitySnapshot.hasData &&
                        connectivitySnapshot.data == false) {
                      return const Center(
                        child: Text(" الاتصال بالانترنت ضعيف أو مفقود"),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
