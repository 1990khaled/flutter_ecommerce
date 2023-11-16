import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/views/widgets/header_of_list.dart';
import 'package:provider/provider.dart';

import '../widgets/list_item_accessori.dart';

class AccessoriesScreen extends StatefulWidget {
  
  const AccessoriesScreen({Key? key}) : super(key: key);

  @override
  State<AccessoriesScreen> createState() => _AccessoriesScreenState();
}

class _AccessoriesScreenState extends State<AccessoriesScreen> {
  TextEditingController searchController = TextEditingController();
  // final _searchFocusNode = FocusNode();
  late List<Product> searchedProduct;
  String value = "";
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    bool isSearching = false;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ThemeData().primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: TextField(
          textAlign: TextAlign.end,
          controller: searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: 'بحث...',
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                setState(() {
                  searchController.clear();
                  FocusScope.of(context).unfocus();
                  value = "";
                });
              },
            ),
          ),
          onChanged: (newValue) async {
            setState(() {
              if (newValue.isNotEmpty) {
                isSearching = true;
                value = newValue;
              }
            });
          },
        ),
      ),

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         AccessoriesSearchWidget(searchCaracter: value),
      //   ),
      // );

      body: Stack(children: [
        if (isSearching = true)
          Visibility(
            visible: isSearching,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 8, left: 10, right: 10, top: 35),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: size.height * 0.75,
                        child: StreamBuilder<List<Product>>(
                            stream: database.salesProductsStream(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                final products = snapshot.data
                                    ?.where((element) => element.title
                                        .toLowerCase()
                                        .contains(value.toLowerCase()))
                                    .toList();

                                // snapshot.data?.where((element) {
                                //   List titleWords =
                                //       element.title.toLowerCase().split(' ');

                                //   return titleWords.any((word) =>
                                //       word.contains(widget.searchCaracter.toLowerCase()));
                                // }).toList();

                                // debugPrint("$snapshot ----------------------");
                                if (products == null || products.isEmpty) {
                                  return const Center(
                                    child: Text('لا يوجد بيانات'),
                                  );
                                }

                                return Builder(builder: (context) {
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
                                });
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      ),
                    ]),
              ),
            )),
          ),
        if (isSearching = false)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  bottom: 8, left: 10, right: 10, top: 10),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
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
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
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
            ),
          ),
        // if (isSearching = false)
      ]),
    );
  }
}
