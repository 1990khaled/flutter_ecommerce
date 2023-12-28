import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/database_controller.dart';
// import '../../widgets/header_of_list.dart';
import '../../../models/product.dart';
import '../../widgets/list_item_accessori.dart';
import 'product_editing_page.dart';

class EditProduct extends StatefulWidget {
  const EditProduct({super.key});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController searchController = TextEditingController();
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
   
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(),
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
                
                value = newValue;
              }
            });
          },
        ),
      ),
      body: Stack(children: [
        
          SafeArea(
              child: Padding(
            padding:
                const EdgeInsets.only(bottom: 8, left: 10, right: 10, top: 35),
            child: SingleChildScrollView(
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
                          // debugPrint("${snapshot.error} ----------------------");
                          if (products == null || products.isEmpty) {
                            // debugPrint("${snapshot.error} ---------------------- $snapshot");
                            return const Center(
                              child: Text("لا يوجد بيانات"),
                            );
                          }

                          return Builder(builder: (context) {
                            return GridView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: products.length,
                              itemBuilder: (_, int index) => Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: InkWell(
                                  onDoubleTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductEditing(
                                                  newProductId:
                                                      products[index].id,
                                                )));
                                  },
                                  onLongPress: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(actions: [
                                              PopupMenuItem(
                                                child: ListTile(
                                                    leading:
                                                        const Icon(Icons.add),
                                                    title: const Text('حذف '),
                                                    onTap: () async {
                                                      await database
                                                          .deleteFromProduct(
                                                              products[index]);
                                                    }),
                                              ),
                                              PopupMenuItem(
                                                child: ListTile(
                                                  leading:
                                                      const Icon(Icons.add),
                                                  title: const Text('رجوع '),
                                                  onTap: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ),
                                            ]));
                                  },
                                  child: Center(
                                    child: ListItemAccessories(
                                        product: products[index]),
                                  ),
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
      ]),
    );
  }
}
