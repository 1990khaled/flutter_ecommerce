import 'package:flutter/material.dart';

import '../company/orders.dart';
import 'add_new_product.dart';
import 'add_newes.dart';
import 'add_product.dart';
import 'edit_new_product.dart';
import 'edit_news.dart';
import 'edit_product.dart';

class MySpecialButtonWidget extends StatelessWidget {
  const MySpecialButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" SpecialButton "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text(
                "ADD Data",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color.fromARGB(255, 26, 27, 26),
                    ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.add),
                iconSize: 50,
                onPressed: () {
                  showMenu(
                    context: context,
                    position: const RelativeRect.fromLTRB(200, 200, 0, 0),
                    items: [
                      PopupMenuItem(
                        child: ListTile(
                          leading: const Icon(Icons.add),
                          title: const Text('Add Offer'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AddNewProductPage()),
                            );
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                          leading: const Icon(Icons.add),
                          title: const Text('Add News'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const AddNewsPage()),
                            );
                          },
                        ),
                      ),
                      PopupMenuItem(
                        child: ListTile(
                            leading: const Icon(Icons.add),
                            title: const Text('Add Product'),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const AddProduct()),
                              );
                            }),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                "Edit Data",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color.fromARGB(255, 26, 27, 26),
                    ),
              ),
              leading: IconButton(
                  icon: const Icon(Icons.add),
                  iconSize: 50,
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(200, 200, 0, 0),
                        items: [
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.edit),
                              title: const Text('Edit News'),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const EditNews()),
                                );
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.edit),
                              title: const Text('Edit Offer'),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditNewProduct()),
                                );
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                                leading: const Icon(Icons.edit),
                                title: const Text('Edit Product'),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EditProduct()),
                                  );
                                }),
                          ),
                        ]);
                  }),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              title: Text(
                "All Orders",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color.fromARGB(255, 26, 27, 26),
                    ),
              ),
              leading: IconButton(
                  icon: const Icon(Icons.card_travel_sharp),
                  iconSize: 50,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllOrdersPage()));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
